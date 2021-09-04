package model1;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;


public class PersonalAlbumDAO {
	
	private DataSource dataSource;
	
	//생성자로 연결
	public PersonalAlbumDAO() {
		// TODO Auto-generated constructor stub
		
		try {
			Context ic = new InitialContext();
			Context evc = (Context)ic.lookup("java:comp/env");
			this.dataSource = (DataSource)evc.lookup("jdbc/mariadb0");
			
		} catch (NamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	
	}
	
	public PersonalAlbumListTO boardList(PersonalAlbumListTO listTO) {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int cpage = listTO.getCpage();
		int recordPerPage = listTO.getRecordPerPage();
		int blockPerPage = listTO.getBlockPerPage();
		
		try {
			conn = this.dataSource.getConnection();
			
			String sql= "";
			
			if(listTO.getType() == null || listTO.getType().equals("all")||listTO.getType().equals("null")) {
				/*sql = "select b.seq, b.category_seq, c.name, b.sub_title, b.family_member_type, "
						+ "b.title, b.content, b.thumb_url, b.nickname, b.is_private "
						+ "b.created_at, b.updated_at"
						+ "from board b inner join board_category c on b.category_seq = c.seq "
						+ "where b.nickname = ? and b.category_seq = '2'; order by seq desc";
				*/
				
				sql = "select nickname, seq, title, content, thumb_url, family_member_type, is_private,"
						+ "created_at, updated_at from board "
						+ "where nickname = ? and category_seq = ? order by seq desc";
				
				pstmt = conn.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
				pstmt.setString(1, listTO.getNickname());
				pstmt.setString(2, listTO.getCatSeq());
				
			}else {
				sql = "select nickname, seq, title, content, thumb_url, family_member_type, is_private,"
						+ "created_at, updated_at from board "
						+ "where nickname = ? and family_member_type = ? and category_seq = ? order by seq desc";
				
				pstmt = conn.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
				pstmt.setString(1, listTO.getNickname());
				pstmt.setString(2, listTO.getType());
				pstmt.setString(3, listTO.getCatSeq());
			};
			
			rs = pstmt.executeQuery();
			
			//게시물 카운트
			rs.last();
			listTO.setTotalPages(rs.getRow());
			rs.beforeFirst(); 
			
			listTO.setTotalPages((listTO.getTotalPages()-1)/recordPerPage+1);
			
			int skip = (cpage-1)*recordPerPage;
			if(skip != 0) {
				rs.absolute(skip);
			}
			
			//데이터 담은 to Arraylist
			ArrayList<PersonalAlbumTO> boardLists = new ArrayList<PersonalAlbumTO>();
			
			for(int i = 0; i < recordPerPage && rs.next(); i++) {
				
				//앨범 게시물
				PersonalAlbumTO to = new PersonalAlbumTO();
				
				to.setNickname(rs.getString("nickname"));
				to.setSeq(rs.getString("seq"));  //글 seq
				to.setTitle(rs.getString("title"));
				to.setContent(rs.getString("content"));
				to.setThumbUrl(rs.getString("thumb_url"));
				to.setFamilyMember(rs.getString("family_member_type"));
				to.setIsPrivate(rs.getBoolean("is_private"));
				to.setwDate(rs.getString("created_at"));
				to.setmDate(rs.getString("updated_at"));
				
				boardLists.add(to);
			}
			
			listTO.setBoardLists(boardLists);
			listTO.setStartBlock((cpage-1)/blockPerPage*blockPerPage+1);
			listTO.setEndBlock((cpage-1)/blockPerPage*blockPerPage+blockPerPage);
			
			if(listTO.getEndBlock() >= listTO.getTotalPages()) {
				listTO.setEndBlock(listTO.getTotalPages());
			}
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("[에러]: "+e.getMessage());	
			
		}finally{
			if(rs!=null) try{rs.close();} catch(SQLException e) {};
			if(pstmt!=null) try{pstmt.close();} catch(SQLException e) {};
			if(conn!=null) try{conn.close();} catch(SQLException e) {};
		}
		
		return listTO;
	}
	
	public int writeOk(PersonalAlbumTO to) {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int flag = 0; //쓰기 실패
		
		try {
			conn = this.dataSource.getConnection();
			
			String sql = "insert into board values ("
					+ "0, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, now(), now(), ?) ";
			pstmt = conn.prepareStatement( sql );
			pstmt.setString(1, to.getCatSeq());
			pstmt.setString(2, to.getSubTitle());
			pstmt.setString(3, to.getSaleStatus());
			pstmt.setString(4, to.getFamilyMember());
			pstmt.setString(5, to.getTitle() );
			pstmt.setString(6, to.getContent() );
			pstmt.setString(7, to.getThumbUrl() );
			pstmt.setString(8, to.getNickname() );
			pstmt.setInt(9, to.getLikeCount());	
			pstmt.setInt(10, to.getHit());	
			pstmt.setBoolean(11, to.getIsPrivate() );	
			
			int result = pstmt.executeUpdate();
			if( result == 1 ) {
				flag = 1; //성공
			}
			
		} catch( SQLException e ) {
			System.out.println( "[에러] " + e.getMessage() );
		} finally {
			if( pstmt != null ) try { pstmt.close(); } catch(SQLException e) {}
			if( rs != null ) try { rs.close(); } catch(SQLException e) {}
			if( conn != null ) try { conn.close(); } catch(SQLException e) {}
		}
		
		return flag;
	}
	
	public PersonalAlbumTO view(PersonalAlbumTO to) {
		
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = this.dataSource.getConnection();
			
			/*String sql = "select b.seq, b.category_seq, c.name, b.sub_title, b.family_member_type, "
					+ "b.title, b.content, b.thumb_url, b.nickname, b.is_private "
					+ "from board b inner join board_category c on b.category_seq = c.seq "
					+ "where b.nickname = ? and b.category_seq = ? and b.seq= ?";
					*/
			
			String sql = "select nickname, seq, title, content, thumb_url, family_member_type, "
					+ "is_private, created_at, updated_at from board "
					+ "where nickname = ? and seq=? and category_seq = ?";
			
			pstmt = conn.prepareStatement( sql );
			pstmt.setString( 1, to.getNickname() );
			pstmt.setString( 2, to.getSeq() );
			pstmt.setString( 3, to.getCatSeq());
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				to.setSeq(rs.getString("seq"));  //글 seq
				to.setNickname(rs.getString("nickname"));
				to.setTitle(rs.getString("title"));
				to.setContent(rs.getString("content"));
				to.setThumbUrl(rs.getString("thumb_url"));
				to.setFamilyMember(rs.getString("family_member_type"));
				to.setIsPrivate(rs.getBoolean("is_private"));
				to.setwDate(rs.getString("created_at"));
				to.setmDate(rs.getString("updated_at"));
			}
			
		} catch( SQLException e ) {
			System.out.println( "[에러] " + e.getMessage() );
		} finally {
			if( pstmt != null ) try { pstmt.close(); } catch(SQLException e) {}
			if( rs != null ) try { rs.close(); } catch(SQLException e) {}
			if( conn != null ) try { conn.close(); } catch(SQLException e) {}
		}
		
		return to;
	}
	
	public int deleteOk(PersonalAlbumTO to) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int flag = 1;
		
		
		try {
			conn = this.dataSource.getConnection();
			/*
			String sql = "select thumb_url from board where seq =?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, to.getSeq());
			rs = pstmt.executeQuery();
			
			String filename = null;
			if(rs.next()) {
				filename = rs.getString("filename");
			}
			*/
			
			String sql = "delete from board where nickname = ? and category_seq=? and seq =?";
			pstmt = conn.prepareStatement( sql );
			pstmt.setString( 1, to.getNickname() ); 
			pstmt.setString( 2, to.getCatSeq() ); 
			pstmt.setString( 3, to.getSeq() ); //글 seq
			
			int result = pstmt.executeUpdate();
			if( result == 1 ) {
				flag = 0; //성공
			}
			
		} catch( SQLException e ) {
			System.out.println( "[에러] " + e.getMessage() );
		} finally {
			if( pstmt != null ) try { pstmt.close(); } catch(SQLException e) {}
			if( rs != null ) try { rs.close(); } catch(SQLException e) {}
			if( conn != null ) try { conn.close(); } catch(SQLException e) {}
		}
		
		return flag;
	}

}
