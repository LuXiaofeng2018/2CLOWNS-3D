!%%%%%%%%%%%%%%%%%%%%% MODULE: ARRAYS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
! -> Lists the all the arrays used in the program
module arrays
    use type_list, only: cellflag, ranke, Layer, locinfo, boundary
    use variables, only: ZERO
    logical :: one_dim_array= .true. ! ��{�͈ꎟ���z��Bfalse�̂Ƃ��O�����z��B
    logical :: xyzn = .true. ! ��{��xyzn�Bfalse�̂Ƃ�xyz�B
    logical :: dim3d = .true. ! ��{�͎O������́Afalse �̂Ƃ��񎟌����
    logical :: drift = .false. ! �Y�����̗L���@��{�͂Ȃ��B
    logical :: nsdata = .false. ! nsdata�̗L���@��{�͂Ȃ��B
    logical :: cplusp = .false. ! �n�`�{�|���S���̏ꍇ
    integer :: date_time_old(1:8)=0,date_time_start(1:8)=0!�@���O�v������ ����с@����v������
    integer :: ls(0:2),le(0:2)  ! ls={is,js,ks} le={ie,je,ke}
    integer :: lf(0:2,0:2)

    !From wave module
    type(boundary) :: BC(2:3)
    type(locinfo),allocatable,dimension(:) :: locout
    integer,allocatable,dimension(:) :: filenums
    real*8,allocatable,dimension(:) :: IWD, FSL, FSLmax
    real*8,allocatable,dimension(:,:) :: Flux_3D, U_3D, U_3Dmax
    real*8,allocatable :: eta_in(:,:), vel_in(:,:,:,:)
    
    ! 2DH array !
    type(Layer),allocatable,dimension(:) :: L !The array for each layer
    integer :: ix(2,2) !To add or substract from the correct dimension inside loop
    
    character(len=255),allocatable,dimension(:)::OBJECTshape,DRIFTshape !�`��f�[�^��

    real*8,allocatable:: dx(:,:) ! �i�q�Ԋu
    real*8,allocatable:: x(:,:) ! �i�q���W
    real*8,allocatable,dimension(:):: dxi,dy,dz ! �i�q�Ԋu1D�\��
    real*8,allocatable,dimension(:):: xi,y,z ! �i�q���W1D�\��
    integer,allocatable:: nf3(:,:,:)  ,nf3p(:,:,:) ! �i�q�t���O,�O�X�e�b�v�i�q�t���O
    integer,allocatable:: nfb3(:,:,:) ,nfb3p(:,:,:) ! �i�q�T�u�t���O,�O�X�e�b�v�i�q�T�u�t���O
    type(cellflag),allocatable,dimension(:):: nff !�����i�q�t���O
    integer,allocatable:: mn(:,:,:)  ! �O�����ʒu(i,k,j) -> �ꎟ���ʒu�@nn
    integer,allocatable,dimension(:)::in,jn,kn  ! �ꎟ���ʒu�@nn  ->  �O�����ʒu(i,k,j)
    integer,allocatable,dimension(:,:)::in2D, mn2D !2D cell mapping
    integer,allocatable,dimension(:)::fln  ! �����Z���{���ʃZ���̃��X�g�@�i����+���ʒʂ��ԍ��j�[���@�Z���ԍ�
    integer,allocatable,dimension(:)::sfn  ! ���ʃZ���̃��X�g�@�i���ʒʂ��ԍ��j�[���@�Z���ԍ�

    integer,allocatable::ipo(:,:) !�e�ʂ̒��_��
    integer,allocatable::npo(:,:,:) !�e�ʂ̒��_�̂Ȃ��
    integer,allocatable::ivt(:),ipl(:) ! �ekdc�̑����_���A���ʐ�
    integer,allocatable::objnoi(:),objno(:) ! �n�`�Z���ʂ��ԍ��@�|�� �Z���ԍ��A  �Z���ԍ��|���n�`�Z���ʂ��ԍ�

    integer,allocatable::sfnoi(:),sfno(:) ! ���ʃZ���ʂ��ԍ��@�|�� �Z���ԍ��A  �Z���ԍ��|�����ʃZ���ʂ��ԍ�
    integer,allocatable::sfno2i(:),sfno2(:) ! ���ʒʂ��ԍ��@�|�� �Z���ԍ��A  �Z���ԍ��|�����ʒʂ��ԍ�
    integer,allocatable,dimension(:,:,:)::ncpl0,info_0 ! �n�`�`����
    integer,allocatable,dimension(:,:,:)::ncpl1,info_1 ! �Y�����`����
    integer,allocatable,dimension(:,:)::ncplc  !�Z���̒��_�̕���
    integer,allocatable,dimension(:,:)::ncpl  !�e�ʓ��̒��_�̕���
    integer,allocatable,dimension(:,:,:)::ncpls ! ���ʌ`����

    integer,allocatable,dimension(:)::mmd ! �Z�O�����g�\�ʂ̑���or�ʂ��ԍ��@(kdc)
    integer,allocatable,dimension(:,:)::nd ! �Z�O�����g�e�ʒ����@ (kdc,mmdmx)
    integer,allocatable,dimension(:,:,:)::IDP
                                        ! �Z�O�����g�̊e�ʂ̏��@ (kdc,mmd(kdc),1:2) -> (�܂܂��Z���ԍ�:�S�̂ł̖ʔԍ��j
    integer,allocatable,dimension(:)::mmd2 ! �񎟌��������̃Z�O�����g�ʑ����@ (kdc,mmd2max)
    integer,allocatable,dimension(:,:)::nd2 ! �񎟌��������̃Z�O�����g�e�ʒ��_���@ (kdc,mmd2max)
    integer,allocatable,dimension(:,:,:)::IDP2 ! �񎟌��������̃Z�O�����g�e�ʂ̏��@ (kdc,mm2,1:2)

    integer,allocatable,dimension(:)::nds ! �e���ʂ̒��_���@�i���ʒʂ��ԍ��j

    integer,allocatable,dimension(:)::idri_kdc ! (ndri_face)  �Y�����\�ʒʂ��ԍ� -> �Y�����ԍ��̊֌W
    integer,allocatable,dimension(:)::idri_fc_n ! (ndri_face)  �Y�����\�ʒʂ��ԍ� -> �Z�����ʔԍ�
    integer,allocatable,dimension(:,:)::idri_fc_all_n !  �Y�����ԍ�,�Z�����ʔԍ� ->�Y�����\�ʒʂ��ԍ�
    integer,allocatable,dimension(:,:)::men ! �Z���̖ʏ��
    integer,allocatable,dimension(:,:)::path0 ! �ӂ̂Ȃ���
    integer,allocatable,dimension(:,:)::side     ! �i�q�̕ӂ̒�`

    real*8,allocatable,dimension(:,:):: u,un ! �����A���X�e�b�v����
    real*8,allocatable,dimension(:,:,:):: ui,v,w ! �����A���X�e�b�v����(�O�����z��)
    real*8,allocatable,dimension(:,:):: qf ! �ړ�����̐�[m/s]
    real*8,allocatable,dimension(:,:,:):: ox ! adv+vis
    real*8,allocatable,dimension(:):: f,fp,p ! �[�U���A���X�e�b�v�[�U���A����
    real*8,allocatable,dimension(:,:,:):: f3 ! �[�U���R�����z�u
    real*8,allocatable,dimension(:,:,:):: p3 ! ���͂R�����z�u
    real*8,allocatable,dimension(:,:):: A,A0,AD ! �J�����A�J�����ǂݍ��ݒl
    real*8,allocatable,dimension(:,:,:):: ax,ay,az ! �J�����R����
    real*8,allocatable,dimension(:):: fb,fb0,fbd ! �󌄗��A�󌄗��ǂݍ��ݒl
    real*8,allocatable,dimension(:,:,:):: fb3 ! �󌄗��R����
    real*8,allocatable,dimension(:,:,:)::vt !  ���_���W
    real*8,allocatable,dimension(:,:)::vtplus !  ���_�̕��s�ړ�
    real*8,allocatable,dimension(:)::vtplus_s !  ���_�̕��s�ړ�
    type(ranke),allocatable,dimension(:)::r,r1 !  �����G�l���M�[

    real*8,allocatable,dimension(:) :: d,pro,prop,SS !  �Q���S���A�����G�l���M�[������, �����G�l���M�[������(previous),strain-rate
    real*8,allocatable,dimension(:) :: AsUs 
    real*8,allocatable,dimension(:,:)::sp,spn ! ���ʂ̏d�S,���X�e�b�v
    real*8,allocatable,dimension(:,:)::nor ! ���ʂ̕�����

    real*8,allocatable,dimension(:)::rhod ! ���̖��x
    real*8,allocatable,dimension(:)::md ! ���̎���
    real*8,allocatable,dimension(:,:,:)::pp_0 ! �n�`�`��̒��_
    real*8,allocatable,dimension(:,:,:)::pp_1 ! �Y�����`��̒��_
    real*8,allocatable,dimension(:,:,:)::pp_s ! ���ʌ`��̒��_
    real*8,allocatable,dimension(:,:,:)::xxmax,xxmin !���̕\�ʂ�(xmax,ymax,zmax)�����(xmin,ymin,zmin)
    real*8,allocatable,dimension(:,:)::vtmx,vtmn !���̂�(xmax,ymax,zmax)�����(xmin,ymin,zmin)

    real*8,allocatable,dimension(:,:,:,:)::dp  ! �Z�O�����g�e�ʂ̒��_���
    real*8,allocatable,dimension(:,:,:,:)::dp2 ! �񎟌��������̃Z�O�����g�e�ʂ̒��_���
    real*8,allocatable,dimension(:,:,:)::surfp !�@���ʂ̒��_�@�i���ʔԍ��A���сA���W�j
    real*8,allocatable,dimension(:,:)::cplc     !(1:6,0:3) �i�q�ʂ̕��ʕ�����
    real*8,allocatable,dimension(:,:)::cpl      !(1:mmp,0:3) �S�Ă̕��ʕ�����
    real*8,allocatable,dimension(:,:,:)::upl !(kdc,�ʔԍ�,1:4) ���̊e�ʂ̕������i�O�������j
    real*8,allocatable,dimension(:,:)::upl0      !  �Z���ʂ̒P�ʖ@���x�N�g��

    !allocate(pp_0(1:mm0mx,0:mcipmx,0:2),ncpl0(mm0mx,0:ncpl00max,-2:mcfvtmx),info_0(mm0mx,1:2,1:mcipmx))
    real*8,allocatable,DIMENSION(:,:)::c !,cfx,cfy,cfz
    real*8,allocatable,DIMENSION(:,:,:)::cf
    real*8,allocatable,DIMENSION(:)::dia
    real*8,allocatable,DIMENSION(:)::te
    real*8,allocatable,DIMENSION(:,:)::CN
    real*8,allocatable,DIMENSION(:)::TEN
    real*8,allocatable,DIMENSION(:)::cmax,cmin

    real*8,allocatable,DIMENSION(:)::rho,rhon  !,rhow
    real*8 :: fc(0:2) ! �O��

    real*8,allocatable,dimension(:,:)::GD,GDP !(mdri,3)
    real*8,allocatable,dimension(:,:)::vvd,vvdp
    real*8,allocatable,dimension(:,:)::acc !(mdri,3)
    real*8,allocatable,dimension(:,:)::FFD,FFDp,rot,rotp !(mdri,3)
    real*8,allocatable,dimension(:,:)::roll_radius,omega,omegap,domega,domegap,theta,thetap

    !Matrix ones
    real*8,allocatable,dimension(:)   :: b, de, de_c, xe
    real*8,allocatable,dimension(:,:) :: alu, alu_c
    integer,allocatable :: mno(:,:,:), mno2mn(:)
    integer,allocatable,dimension(:,:) :: llu, LL_C

    real*8,allocatable,dimension(:,:)::Iner  ! Iner(kdc,xyz����):�Y�����̊������[�����g(mdri,1:3)
    real*8,allocatable,dimension(:,:)::Inerbym  ! Iner(kdc,xyz����):�Y�����̊������[�����g(mdri,1:3)
    !======================= 2014/05/19 =======================================================================
    real*8,allocatable,dimension(:,:,:)::Iner2,Iner2p !Iner2(kdc,3*3):�Y�����̊������[�����g(mdri,1:3,1:3)
    real*8,allocatable,dimension(:,:,:)::INV_iner2 !Iner2(kdc,3*3):�Y�����̊������[�����g(mdri,1:3,1:3) inverse matrix
    !===========================================================================================================
    real*8,allocatable,dimension(:,:)::dgd   !(mdri,1:3)
    integer,allocatable,dimension(:)::idm  ! �Y����������ɐÎ~���Ă���Ƃ�0�C�����Ă���Ƃ�1 (mdri)
    real*8,allocatable,dimension(:,:)::uplb  ! ��͗̈�̕\��(1:mp,1:4)

    !real*8,allocatable,dimension(:,:)::mftan,mftanp  !�W����ɂ��ڐ������̗�
    real*8,allocatable,dimension(:,:)::dtheta  ! theta(i):i�����̉�]�p (mdri,3)

    real*8,allocatable,dimension(:,:,:)::DVECp  ! DVEC(kdc,i,1�`3):i���̕����x�N�g�� !(mdri,1:3,1:3)
    real*8,allocatable::fix(:),fixp(:,:)  !��]��
    !integer,allocatable::drinoi(:),drino(:) ! �Y�����𕔕��I�Ɋ܂ރZ���ʂ��ԍ��@�|�� �Z���ԍ��A  �Z���ԍ��|���Y�����𕔕��I�ɃZ���ʂ��ԍ�
    !integer,allocatable::drino2i(:),drino2(:,:) ! �Y���������Z���ʂ��ԍ��@�|�� �Z���ԍ��A  �i�Z���ԍ�,�Y�����ԍ��j�|���Y���������Z���ʂ��ԍ�
    integer,allocatable,dimension(:)::DRINO,DRINOP,DRINOK !�Y�������܂ރZ���̒ʂ��ԍ�
    integer,allocatable,dimension(:,:)::DRINO2,DRINO2K,DRINO2p !�Y���������Z���̒ʂ��ԍ�
    integer,allocatable,dimension(:)::DRINOI,DRINO2I,DRINOIK,DRINO2IK

        !!!!!!!!!!!
        !real*8,allocatable::fix(:),fixp(:,:)  !��]��
        !!!!!!!!!!!    
!#ifdef DRI2        
!        integer,dimension(mnh)::DRI2PNOI,DRI2PNOIP  !(nn)  ���f�Z���̒ʂ��ԍ�����Z���ʂ��ԍ��̋t����
!        integer,dimension(100,3)::DRI2PNO !(mm2p,1) ���Y�Z���̃Z���̒ʂ��ԍ�nn, (mm2p,2) ���f��
!        real*8,dimension(100,10,6)::axyz,axyzd,axyz2  !���f���ꂽ�e�����̊J����
!        real*8,dimension(100,10,6)::Vxyz,Vxyzn  !���f���ꂽ�e�����̗���        
!        real*8,dimension(100,10)::P2P  !���f���ꂽ�e�����̈���        
!        real*8,dimension(100,10)::FB2P,FB2PD,FB2P2,F2P !(mm2p,idvd) ���f���ꂽ�e�����̋󌄗�  
!        integer,dimension(100,10)::NF2P !(mm2p,idvd) ���f���ꂽ�e�����̃Z���t���O              
!#endif

    contains

!%%%%%%%%%%%%%%%%%%%%% SUBROUTINES: ALLOCATIONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
! -> The following subroutines allocate the sizes of the arrays listed above
    subroutine alloc_drift(ndri)
        implicit none
        integer,intent(in)::ndri
        allocate(md(1:ndri))
        allocate(Iner(ndri,3),Iner2(ndri,3,3),Iner2p(ndri,3,3), inv_iner2(ndri, 3, 3))
#ifdef FLAPGATE    
        allocate(fix(ndri))                            !!!!!!!!!!!!��]���S����
        allocate(fixp(ndri,3))                       !!!!!!!!!!!!��]���S�ƂȂ�_   
#endif    
        allocate(dtheta(ndri,3),omega(ndri,3),vvd(ndri,3),domega(ndri,3),domegap(ndri,3));dtheta=ZERO;omega=ZERO;vvd=ZERO;domega=ZERO
        allocate(omegap(ndri,3),vvdp(ndri,3),roll_radius(ndri,3)) ;vvdp=ZERO;omegap=0;roll_radius=0
        allocate(rot(ndri,3),rotp(ndri,3),ffdp(ndri,3),ffd(ndri,3),acc(ndri,3));rot=ZERO;rotp=ZERO;ffd=ZERO;ffdp=ZERO;acc=ZERO
        allocate(GDp(ndri,3),thetap(ndri,3),dGD(ndri,3))   ;GDp=ZERO  ;thetap=0 ;dGD=ZERO
        allocate(DVECp(1:ndri,1:3,1:3)) ;DVECp=ZERO
        !

        !
    end subroutine

    subroutine alloc_quvwf(mnh1)
        implicit none
        integer::mnh1
        allocate(qf(0:2,0:mnh1+1))
    end subroutine   

    subroutine alloc_dxdydz(mx0,my0,mz0,mx1,my1,mz1)
        implicit none
!        logical::oned
        integer::mx0,my0,mz0,mx1,my1,mz1,mnh1,mx2
        mx2=max(mx1,my1,mz1)
        mnh1=(mx1-mx0+1)*(my1-my0+1)*(mz1-mz0+1)
    
    if(one_dim_array) then
        allocate(dx(0:2,mx2));dx=ZERO
        allocate(x(0:2,mx2));x=ZERO
    else
        allocate(dxi(mx0-2:mx1),dy(my0-2:my1),dz(mz0-2:mz1));dxi=ZERO;dy=ZERO;dz=ZERO
        allocate(xi(mx0-2:mx1),y(my0-2:my1),z(mz0-2:mz1));xi=ZERO;y=ZERO;z=ZERO
    endif
    !    allocate(nf(mx0-2:MX1,mz0-2:mz1,my0-2:my1),nfb(mx0-2:MX1,mz0-2:mz1,my0-2:my1))
    !    allocate(nfbp(mx0-2:MX1,mz0-2:mz1,my0-2:my1),nfp(mx0-2:MX1,mz0-2:mz1,my0-2:my1))
        allocate(mn(mx0-2:MX1,mz0-2:mz1,my0-2:my1));mn=0
        allocate(nff(0:mnh1));nff(:)%f=-1;nff(:)%b=0
        allocate(in(Mnh1),jn(Mnh1),kn(Mnh1))
    end subroutine

    subroutine alloc_uvwfp(mnh1)
        use variables, only: TOME
        implicit none
        integer :: mnh1
        allocate(u(0:2,0:mnh1+1),un(0:2,0:mnh1+1));u=ZERO
        allocate(f(0:mnh1+1),fp(0:mnh1+1),p(0:mnh1));f=ZERO;p=ZERO    
        allocate(ox(TOME,0:2,0:mnh1));ox = ZERO !;ox1=0.0d0ox1(0:2,0:mnh1));
        allocate(sfn(Mnh1),fln(Mnh1))
    end subroutine alloc_uvwfp

    subroutine alloc_a0fb0(mnh1,mnh2)
        implicit none
        integer::mnh1,mnh2
        allocate(a0(0:2,0:mnh1+1),fb0(0:mnh2+1));a0=ZERO;fb0=ZERO
    end subroutine alloc_a0fb0

    subroutine alloc_afb(mnh1,mnh2)
        implicit none
        integer::mnh1,mnh2
        allocate(A(0:2,0:mnh1+1),fb(0:mnh2+1));a=ZERO;fb=ZERO
    end subroutine alloc_afb

    subroutine alloc_adfbd(mnh1,mnh2)
        implicit none
        integer::mnh1,mnh2
        allocate(Ad(0:2,0:mnh1+1),fbd(0:mnh2+1));ad=ZERO;fbd=ZERO
    end subroutine alloc_adfbd

    subroutine alloc_aked(mnh1)
    use variables, only: vt_op
    implicit none
    integer::mnh1
    ! Turbulent viscosity and production
    allocate(d(0:mnh1+1),pro(0:mnh1+1),prop(0:mnh1+1))
    allocate(r1(0:mnh1+1),r(0:mnh1+1)) 
    if (vt_op.eq.2) then
        ! Smagorinsky
        allocate(ss(0:mnh1+1))
    elseif (vt_op.eq.3) then
        ! Realizable k-eps
        allocate(ss(0:mnh1+1),AsUs(0:mnh1+1)) 
    endif
#ifdef FURYOKU
    allocate(frate(0:mnh1))
#endif
#ifdef REY
    allocate(ru(0:mnh1));allocate(ru(1,0:mnh1));allocate(ru(2,0:mnh1))
#endif
    end subroutine

    subroutine alloc_for_segment(ndri,mm0mx,mmdmx,mmd2mx,ncpl02max,inne2)
      !  use variables
        implicit none
        integer,intent(in)::ndri,mm0mx,mmdmx,mmd2mx,ncpl02max,inne2
     !   if(.not.allocated(OBJNO)) then
     !   allocate(OBJNOi(1:mm0mx))
     !   allocate(OBJNO(0:inne2))
     !   endif
        allocate(vtmx(1:ndri,0:2),vtmn(1:ndri,0:2))
        allocate(mmd(1:ndri),mmd2(1:ndri))
     !   allocate(IDP(1:ndri,1:mmdmx,1:2))
     !   allocate(dp(1:ndri,1:mmdmx,1:ncpl02max,1:3))
     !   allocate(nd(1:ndri,1:mmdmx))
     !   allocate(IDP2(1:ndri,1:mmd2mx,1:2))
     !   allocate(dp2(1:ndri,1:mmd2mx,1:ncpl02max,1:3))
     !   allocate(nd2(1:ndri,1:mmd2mx))
    
    end subroutine alloc_for_segment

    subroutine alloc_norsp(mnh1)
          implicit none
          integer::mnh1
          allocate(sp(0:mnh1+1,0:2));allocate(spn(0:mnh1+1,0:2))
          allocate(nor(0:mnh1,0:3))
    end subroutine

    subroutine alloc_uivwp3(ie1,je1,ke1)
    implicit none
    integer::ie1,ke1,je1
    allocate(ui(1:ie1+1,1:ke1+1,1:je1+1))
    allocate(v(1:ie1+1,1:ke1+1,1:je1+1))
    allocate(w(1:ie1+1,1:ke1+1,1:je1+1))
    allocate(p3(1:ie1+1,1:ke1+1,1:je1+1))
    allocate(f3(1:ie1+1,1:ke1+1,1:je1+1))
    ui=ZERO;v=ZERO;w=ZERO;p3=ZERO;f3=ZERO
    end subroutine alloc_uivwp3

    subroutine alloc_fnfnfb(ie1,je1,ke1)
    implicit none
    integer::ie1,ke1,je1
    if(.not.allocated(f3)) then
        allocate(f3(1:ie1+1,1:ke1+1,1:je1+1))
        f3=ZERO
    endif
    allocate(nf3(1:ie1+1,1:ke1+1,1:je1+1),nfb3(1:ie1+1,1:ke1+1,1:je1+1))
    end subroutine

    subroutine alloc_axyzfb3(ie1,je1,ke1)
    implicit none
    integer::ie1,ke1,je1
    allocate(ax(1:ie1+1,1:ke1+1,1:je1+1),ay(1:ie1+1,1:ke1+1,1:je1+1),az(1:ie1+1,1:ke1+1,1:je1+1),fb3(1:ie1+1,1:ke1+1,1:je1+1))
    ax=ZERO;ay=ZERO;az=ZERO;fb3=ZERO
    end subroutine
    subroutine alloc_c(mfk1,mnh1)
    integer::mnh1,mfk1
    allocate(c(0:mfk1,0:mnh1),cf(0:2,0:mfk1,0:mnh1))  !,cfy(0:mfk1,0:mnh1),cfz(0:mfk1,0:mnh1))
    allocate(cn(0:mfk1,0:mnh1))
    c=ZERO;cn=ZERO;cf=ZERO  !;cfy=ZERO;cfz=ZERO
    end subroutine alloc_c

    subroutine alloc_te(mnh1)
    implicit none
    integer::mnh1
    allocate(te(0:mnh1))
    allocate(ten(0:mnh1))
    te=ZERO;ten=ZERO
    end subroutine alloc_te

    subroutine alloc_rho(mnh1)
    implicit none
    integer::mnh1
    allocate(rho(0:mnh1))
    allocate(rhon(0:mnh1))
    rho=ZERO;rhon=ZERO
    end subroutine
    ! For matrix elements
    subroutine dealloc_matrix
    deallocate(b)
    deallocate(de)
    deallocate(xe)
!    deallocate(dd)
!    deallocate(wk)
    deallocate(alu)
    deallocate(mno)
    deallocate(llu)
    deallocate(mno2mn)
    end subroutine

    subroutine alloc_matrix(mm0,mx1,my1,mz1)
    use variables, only: mm2, nl
    implicit none
    integer,intent(in)::mm0,mx1,my1,mz1
    mm2 = mm0
    allocate(b(mm0))
    allocate(de(mm0))
    allocate(xe(0:mm0))
!    allocate(dd(0:mm0))
!    allocate(wk(0:mm0,5))
    allocate(alu(mm0,nl))
    allocate(mno(mx1,mz1,my1))
    allocate(llu(mm0,nl))
     allocate(mno2mn(1:mm0))
    end subroutine
    
    ! 2DH allocation    
    subroutine alloc_XY(LN,mn2Dx,mn2Dy,ks2D,ke2D)
        integer,intent(in) :: LN,mn2Dy,mn2Dx,ks2D,ke2D
        !Allocate the arrays with multi-dimensions
        allocate(L(LN)%Z(ks2D-2:ke2D+1),L(LN)%X(mn2Dx),L(LN)%Y(mn2Dy))
        allocate(L(LN)%MN(mn2Dx,mn2Dy),L(LN)%MND(mn2Dx,mn2Dy))
        allocate(L(LN)%NF(mn2Dx,ks2D-1:ke2D,mn2Dy),&
                 L(LN)%NFB(mn2Dx,ks2D-1:ke2D,mn2Dy))
        ! The spherical coordinate arrays
        if (L(LN)%GEOC.eq.1) allocate(L(LN)%secY(mn2Dy),L(LN)%sinY(mn2Dy))
        IX(1,:) = [ 1, 0 ]
        IX(2,:) = [ 0, 1 ]
    endsubroutine alloc_XY
!
    subroutine alloc_F(LN,DIM,mn2Dh)
    integer,intent(in) :: LN,DIM,mn2Dh
        !Allocate arrays of single dimension (or with 2 for x and y directions)
        allocate(L(LN)%MAN(0:mn2Dh),L(LN)%ZK(0:mn2Dh),L(LN)%ZKm(0:mn2Dh))
        allocate(L(LN)%ETA(0:mn2Dh),L(LN)%ETAn(0:mn2Dh),L(LN)%F(0:mn2Dh))
        allocate(L(LN)%INW(2,0:mn2Dh),L(LN)%IND(2,0:mn2Dh))
        allocate(L(LN)%RX(DIM,0:mn2Dh),L(LN)%RXc(DIM,0:mn2Dh))
        allocate(L(LN)%DX(DIM,0:mn2Dh),L(LN)%H(DIM,0:mn2Dh))
        allocate(L(LN)%Q(DIM,0:mn2Dh),L(LN)%Qn(DIM,0:mn2Dh))
        allocate(L(LN)%Dn(DIM,0:mn2Dh),L(LN)%D(DIM,0:mn2Dh))
        allocate(L(LN)%U(L(LN)%DIM,0:L(LN)%inne),L(LN)%Qs(DIM,0:mn2Dh))
        L(LN)%U(:,0)= ZERO ; L(LN)%MAN(0) = ZERO ; L(LN)%INW = 0
        L(LN)%ZK(0) = L(LN)%Z(L(LN)%ke) ; L(LN)%ZKm(0) = L(LN)%Z(L(LN)%ke)
        L(LN)%ETAn(0) = L(LN)%Z(L(LN)%ke) ; L(LN)%F(0) = ZERO
        L(LN)%DX(:,0) = ZERO ; L(LN)%Q(:,0) = ZERO ; L(LN)%RX(:,0) = ZERO
        L(LN)%Dn(:,0) = ZERO;L(LN)%Qs(:,0) = ZERO ; L(LN)%Qn(:,0) = ZERO
        L(LN)%D(:,0) = ZERO ; L(LN)%H(:,0) = -L(LN)%Z(L(LN)%ke)
        L(LN)%ETA(0) = L(LN)%Z(L(LN)%ke) ; L(LN)%IND = 0 ; L(LN)%MND = 0
        !Maximum Value arrays
        allocate(L(LN)%ETAmax(0:mn2Dh)) ; L(LN)%ETAmax(0) = ZERO
        allocate(L(LN)%Umax(DIM,0:mn2Dh)) ; L(LN)%Umax(:,0) = ZERO
    endsubroutine alloc_F
!%%%%%%%%%%%%%%%%%%%%% END OF MODULE: ARRAYS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end module arrays    