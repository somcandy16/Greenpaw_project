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


public class ThumbDAO {
	private DataSource dataSource;
	
	public ThumbDAO() {
		// TODO Auto-generated constructor stub
		try {
			Context initCtx = new InitialContext();
			Context envCtx = (Context)initCtx.lookup( "java:comp/env" );
			this.dataSource = (DataSource)envCtx.lookup( "jdbc/mariadb0" );
		} catch (NamingException e) {
			// TODO Auto-generated catch block
			System.out.println( "[에러] " + e.getMessage() );
		}
	}
	public ArrayList<BoardTO> boardList() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		ArrayList<BoardTO> datas = new ArrayList<BoardTO>();
		
		try {
			conn = this.dataSource.getConnection();
			
			String sql = "select category_seq, sub_title, sale_status, family_member_type, title, content, thumb_url, nickname, like_count, hit, date_format(created_at, '%Y.%m.%d') created_at, updated_at from board where is_private ='0' order by seq desc";
			pstmt = conn.prepareStatement( sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY );
			
			rs = pstmt.executeQuery();
			
			while( rs.next() ) {
				BoardTO to = new BoardTO();
				to.setCategorySeq( rs.getString( "category_seq" ) );
				to.setSubTitle( rs.getString( "sub_title" ) );
				to.setSaleStatus( rs.getString( "sale_status" ) );
				to.setFamilyMemberType( rs.getString( "family_member_type" ) );
				to.setTitle( rs.getString( "title" ) );
				to.setContent( rs.getString( "content" ) );
				to.setThumbUrl( rs.getString( "thumb_url" ) );
				to.setNickname( rs.getString( "nickname" ) );
				to.setLikeCount( rs.getString( "like_count" ) );
				to.setHit( rs.getString( "hit" ) );
				to.setCreatedAt( rs.getString( "created_at" ) );
				to.setUpdatedAt( rs.getString( "updated_at" ) );
				
				datas.add( to );
			}
		} catch( SQLException e ) {
			System.out.println( "[에러] " + e.getMessage() );
		} finally {
			if( rs != null ) try { rs.close(); } catch( SQLException e ) {}
			if( pstmt != null ) try { pstmt.close(); } catch( SQLException e ) {}
			if( conn != null ) try { conn.close(); } catch( SQLException e ) {}
		}
		return datas;
	}
	
	public BoardListTO boardList(BoardListTO listTO) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int cpage = listTO.getCpage();
		int recordPerPage = listTO.getRecordPerPage();
		int blockPerPage = listTO.getBlockPerPage();
		
		try {
			conn = this.dataSource.getConnection();
			
			String sql = "select category_seq, sub_title, sale_status, family_member_type, title, content, thumb_url, nickname, like_count, hit, date_format(created_at, '%Y.%m.%d') created_at, updated_at from board order by seq desc";
			pstmt = conn.prepareStatement( sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY );
			
			rs = pstmt.executeQuery();
			
			rs.last();
			listTO.setTotalRecord( rs.getRow() );
			rs.beforeFirst();
			
			listTO.setTotalPage( ( ( listTO.getTotalRecord() -1 ) / recordPerPage ) + 1 );
			
			int skip = (cpage -1)* recordPerPage;
			if( skip != 0 ) rs.absolute( skip );
			
			ArrayList<BoardTO> boardLists = new ArrayList<BoardTO>();
			for( int i=0 ; i<recordPerPage && rs.next() ; i++ ) {
				BoardTO to = new BoardTO();
				to.setCategorySeq( rs.getString( "category_seq" ) );
				to.setSubTitle( rs.getString( "sub_title" ) );
				to.setSaleStatus( rs.getString( "sale_status" ) );
				to.setFamilyMemberType( rs.getString( "family_member_type" ) );
				to.setTitle( rs.getString( "title" ) );
				to.setContent( rs.getString( "content" ) );
				to.setThumbUrl( rs.getString( "thumb_url" ) );
				to.setNickname( rs.getString( "nickname" ) );
				to.setLikeCount( rs.getString( "like_count" ) );
				to.setHit( rs.getString( "hit" ) );
				to.setCreatedAt( rs.getString( "created_at" ) );
				to.setUpdatedAt( rs.getString( "updated_at" ) );
				
				boardLists.add( to );
			}
			
			listTO.setBoardLists( boardLists );
			
			listTO.setStartBlock( ( ( cpage -1 ) / blockPerPage ) * blockPerPage + 1 );
			listTO.setEndBlock( ( ( cpage -1 ) / blockPerPage ) * blockPerPage + blockPerPage );
			if( listTO.getEndBlock() >= listTO.getTotalPage() ) {
				listTO.setEndBlock( listTO.getTotalPage() );
			}
		} catch(SQLException e) {
			System.out.println( "[에러] " + e.getMessage() );
		} finally {
			if( rs != null ) try { rs.close(); } catch( SQLException e ) {}
			if( pstmt != null ) try { pstmt.close(); } catch( SQLException e ) {}
			if( conn != null ) try { conn.close(); } catch( SQLException e ) {}
		}
		
		return listTO;
	}
	
	public ArrayList<BoardTO> getSearchList(String categorySeq, String field, String keyword){
		

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		ArrayList<BoardTO> datas = new ArrayList<BoardTO>();
		
		try {
			conn = this.dataSource.getConnection();
			
			String sql = "select * from board where category_seq=? and +field+ like ? order by seq desc";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, categorySeq);
			pstmt.setString(2, field); // ì»¨íì¸ ..
			pstmt.setString(3, "%"+keyword+"%"); //ê²ì ê°
			
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				System.out.println(rs.getString("title"));
				BoardTO to = new BoardTO();
				to.setSeq(rs.getString("seq"));
				to.setSubTitle(rs.getString("sub_title"));
				to.setSaleStatus(rs.getString("sale_status"));
				to.setFamilyMemberType(rs.getString("family_member_type"));
				to.setTitle(rs.getString("title"));
				to.setNickname(rs.getString("nickname"));
				to.setLikeCount(rs.getString("like_count"));
				to.setHit(rs.getString("hit"));
				to.setCreatedAt(rs.getString("created_at"));
				datas.add(to);
				
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if(rs != null) try {rs.close();} catch(SQLException e) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException e) {}
			if(conn != null) try {conn.close();} catch(SQLException e) {}
		}
			return datas;
		}
}
