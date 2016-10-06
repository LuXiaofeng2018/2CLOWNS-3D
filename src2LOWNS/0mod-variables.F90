!%%%%%%%%%%%%%%%%%%%%% MODULE: VARIABLES %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
! -> Lists the all the variables used in the program
module variables
    use type_list, only: bcond, ranke, boundary, inputcond

    type(bcond) :: openbound
    character*3 :: order
    character*10 :: fmt,fmt1
    real :: refval
    
    ! From wave module
    type(inputcond) :: inflow
    character*255 :: inflow_file
    character*255 :: output_file
    integer :: locnum    
    real*8 :: h_in
    real*8 :: GDR = 1.0d0 ! Ground Deformation Rate
    
    !For 2CLOWNS
    integer :: nstart
    real*8  :: Limit_3D = 1d-8
    
    ! 2DH Variables
    integer :: LNUM = 0                       !Number of layers
    real*8  :: tide_level                     !Tide adjustment   
    character*255 :: inputxyz2D
    character*255 :: inputf2D
    character*255 :: input2D 
    character*255 :: title2D
    
    !Parameters
    real*8,parameter :: ZERO = 0.0d0, HALF = 0.5d0, ONE = 1.0d0, TWO = 2.0d0, &
                        THREE = 3d0, THREEQ = 0.75d0, PI_8 = 4d0*atan(1d0),   &                           
                        TWFTH = 1d0/12d0, FTW7 = 4d0/27d0, THIRD = 1d0/3d0,   &  
                        TWOTHIRD = 2d0/3d0, SIXTH = 1d0/6d0, EIGHTH = 1d0/8d0,&
                        FFTH = 1d0/15d0, TW4 = 1d0/24d0, SQRSIX = sqrt(6d0),  &
                        TW7 = 27d0, FIVE = 5d0,                               &
                        ONEHALF = 1.5d0, SVNTHIRD = 7d0/3d0, V_lim = 20d0,    &
                        TINY = 1d-15, VSMALL = 1d-12, SMALL = 1d-9,           &
                        LITTLE = 1d-3, Leps = 1d0 - 1d-5, F_lim = 1d0 + 1d-5, &
                        DT_lim = 1d-6, TEN = 10d0, TENTH = 0.1d0,             &
                        A = 0.4d0, B = 1d0/15d0, karman = 0.41d0,             &
                        COMFLOW = 0.35d0, SUBFLOW = 0.91d0, HCIRC = 180d0,    &
                        R = 1d0/6378137d0, PSI = 14.58423d-5 !2*psi rad/s
                        
    character(len=255) :: INPUT   ! ���̓��C���t�@�C����
    character(len=255) :: INPUTXYZ ! ����XYZ�t�@�C����
    character(len=255) :: INPUTKE ! ����rdata�t�@�C����

    character(len=255) :: INPUTF='non'  ! ����fdata�t�@�C����
    character(len=255) :: INPUTf0='non' ! ����fdata�t�@�C����(�n�`)
    character(len=255) :: INPUTSHAPE ! ����odata�t�@�C����
    character(len=255) :: DRIINIT ! �Y�������ݒ�t�@�C����
    character(len=255) :: INPUTtc      

    character(len=255) :: title,title_temp ! �o�̓t�@�C����
    
    character(len=255) :: TESTA ! �o�̓t�@�C����(t?.???���O�̕����j
    character(len=8)   :: idate  !�����擾�p����
    character(len=255) :: num

    real*8 :: cl_set  !Desired setting of courant number to automatically get dt
    real*8 :: courant !�N�[������
    real*8 :: hasoku_c !�g���N�[������    
    real*8 :: velmax !�����ϓ��̑��a
    integer:: ivmax  !�@�N�[�������Ɋւ�����󂯓n��
    integer:: icon,icong ! �G���[�R�[�h
    integer,parameter::iob=-1 !���̃Z����nf�l
    integer,parameter::ifu=1 !���̃Z����nf�l
    integer::n=0 !���݂̌v�Z�X�e�b�v��
    integer::nkai !�v�Z�̌J��Ԃ���
    integer::mwr ! ���o�͊Ԋu�imwr�X�e�b�v���Ɓj
    integer::dwr ! local data output frequency
    real*8 ::twl ! local data output time
    integer::fg_xyz ! =0 -> .xyz ; =1 -> .xyzn
    integer::ko_tmp ! temp�f�[�^���o�͂���񐔁iko_t=ko_tmp�̂Ƃ��C���ԕt���f�[�^���o�́j
    integer::ko_t  ! temp�f�[�^���o�͂�����
    integer::ko_out  ! sfdata�� maindata��rdata�����ׂ����o�͂���ꍇ�B�i�QD��͂̏ꍇ���������j
    integer::is,js,ks,ie,je,ke
    integer::inns,inne,inne2,inn2d !�Z���ԍ��J�n�ƏI��,���E�Z�����܂߂��I��
    integer::ndri=0 !�@�Y������(�����l0)
    integer::nx1,nx2
    integer:: NTHR = 1 !Number of OMP threads
    integer:: IM = 1   !Model type: = 1 - Hybrid 2D-3D, = 2 - 2DH only, = 3 - 3D only
    

    integer::iplmax
    integer::npln=6  !�����ʐ��@6+sum(ipl(1:ndri))
    integer::ndri_face  ! ���ʒʂ��ԍ�
    integer::mm0=0,mm0mx=10000  ! �n�`���܂ރZ����, �n�`���܂ރZ�����̍ő�l
    integer::mm1=0,mm1mx=10000  ! �Y�����𕔕��I�Ɋ܂ރZ����, �Y�����𕔕��I�Ɋ܂ރZ�����̍ő�l
    integer::mm1f=0,mm1fmx=10000 !�Y�����Ɋ��S�Ɋ܂܂��Z���̑���
    integer::mms,mmsmx=10000 ! ���ʂ��܂ރZ����,���ʂ��܂ރZ�����̍ő�l
    integer::mms2 ! ���ʐ��i��Z���ɕ������ʂ��܂ށB�j
    integer::ncpl01max=60 !25!vertex number in a cell ex. ncpl*(0,1) ! 
    integer::ncpl00max=60 !plain number in a cell  ex. ncpl*(0,0) 
    integer::ncpl02max=80 !25!vertex number of each face in a cell ex ncpl(0,2) !mcfvtmx
    integer::minfopath=300 !path���̏��
    integer::ic1_0,ic2_0,ic3_0
    integer::ipl0=6 ! �Z���̖ʐ�
    integer::ncpls1max=50 !pp_s�@�������̍ő�l
    integer::ncpls0max=50 !ncpls�@�������̍ő�l
    integer::ncpls2max=100 !ncpls�@��O�����̍ő�l
    !integer::ub_surfp_2=30 !surfp�@�������̍ő�l

    integer::mmdmx=30000    !�@�Z�O�����g�ʂ̑����̏��
    integer::mmd2mx=30000    !�@�񎟌��������Z�O�����g�ʂ̑����̏��

    integer::ifln  ! �����Z��+���ʃZ���̑���
    integer::isfn  ! ���ʃZ���̑���
    integer::isfn2  ! ���ʃZ���{�if<1�̓����Z��,f>0�̋�C�Z���j�̑���

    integer :: TOME = 1 !Temporal order of momentum explicit integration 
    
    real*8::t=ZERO,t0 ! ����,�ǂݍ��񂾃f�[�^�̎���
    real*8::dt=0.0d0,dtmax,dt0=0.0d0 ! ���ԍ��݁A���ԍ��ݍő�l,�ǂݍ��񂾃f�[�^�̎��ԍ���
    real*8::dtm !���ԍ��݁C�ǂݍ��ݎ��ԍ���,Previous timestep
    real*8::g  = 9.80665d0 ! �d�͉����x Standard gravity
    real*8::nu = 1.0d-6 ! ���S���W�� Viscosity of water at 20C
    real*8::d0 ! �A�����Ő؂�덷
    real*8::eps0 ! �s��v�Z�Ő؂�덷

    real*8::t_end ! �v�Z�I������
    real*8::tw0  ! ����f�[�^�o�͎���
    real*8::tw   ! ����f�[�^�o�͎���
    real*8::dtw  ! �f�[�^�o�͎��ԊԊu
    real*8::g_read   ! �ǂݍ��݃f�[�^�̏d�͉����x
    real*8::nu_read   ! �ǂݍ��݃f�[�^�̓��S���W��
    real*8::PI = 4d0*atan(1d0) !�~����
    real*8::sdum= -1d4  ! ���ʂ��Ȃ��ꍇ�̃_�~�[�l

    integer :: ike !�����ʂ̓ǂݍ��ݒ���
    integer :: n_ak=1 !�J��Ԃ���
    integer :: ieee !
    real*8::akrate,erate,drate !�����ʂ̕ǖʒጸ��
    real*8::ratez=ZERO,ratex=ZERO,ratey=ZERO !�����ʂ̒���
    real*8::aratez=1.0d0,aratex=1.0d0,aratey=1.0d0 !�����ʂ̒���
    real*8::akrateS !�����ʂ̐��ʒጸ��
    real*8,allocatable,dimension(:)::ak,ak1 !�����G�l�C���X�e�b�v�����G�l
    real*8,allocatable,dimension(:)::e,e1 !�����G�l�U��C���X�e�b�v�����G�l�U��
    real*8,allocatable,dimension(:)::pro !������
    real*8,allocatable,dimension(:)::d !�Q���S���W��
    real*8,parameter:: c_smag = 0.2d0
    ! k - eps coefficients                        ! Realizable coefficients
    real*8,parameter::ce1 = 1.44d0,ce2i = 1.92d0, ce2r = 1.9d0, c1r = 0.43d0, A0 = 4.04 
    real*8,parameter::cm = 0.09d0, Sk = 1.0d0, Se = 1.3d0, Ser = 1.2d0 
    real*8 :: mu ! �S���W��
    real*8 :: ks_r(0:10) !Equivalent sand roughness (m) !<0 = no wall function (no gradient), 0 = smooth wall, >0 rough wall
    integer :: pro_lim !Limiter type for production: = 0 no limiter; = 1 Kato-Launder Mod; = 2 Menter limiter
    integer :: vt_op   !Option for varying nu_t for low RE
    type(ranke) :: r_lim !Limit for k and e
    real*8,parameter :: akmin = 1.92d-15, emin = 1.0d-15, D_rlim = 1d8  
    real*8 :: akini = 1.92d-15, eini = 1.0d-15
    real*8 :: TI_b  = 0.01d0, nut_b = 1d0
    real*8 :: honma = 0.35d0 !�{�Ԏ�
    real*8 :: svmax !�@�N�[�������Ɋւ�����󂯓n��
    ! Courant:  lowest limit   small limit     medium limit
    real*8 :: cr_ll = 0.1d0, cr_sl = 0.2d0, cr_ml = 0.4d0
    !          big limit        upper limit
    real*8 :: cr_bl = 0.6d0, cr_ul = 0.9d0
    
    real*8 :: Uweight = 4d0    !Weight given to Courant number using fluid velocity in 
                               !comparison to the wave speed and turbulent time scale  
    real*8 :: Dweight = 1.1d0  !Weight given to Courant number using diffusion in 
                               !comparison to the wave speed and turbulent time scale  
    real*8::prt=1.0d0/1.6d0
    real*8::prc=1.0d0/1.2d0
    real*8::rhos,dakuin
    real*8::c0,c00,c1,c10
    integer :: ifk0,mfk1
    real*8::rho0=1000.d0
    
    real*8::myu=HALF,myu1=0.3d0  ! myu:�ő�Î~���C�W���Cmyu1:�����C�W��
    real*8::cr !=0.1d  ! cr:�����W��      
    integer :: mm1k, mm11k

    !Matrix ones
    integer::nl
    integer::mm2
    real*8 ::eps   ! �����v�Z�̑Ő؂�덷(����)
    integer::iter   ! �����v�Z�̌J��Ԃ���
    integer::mnoe,m_alloc=0
    integer::ik
    real*8::DMAX
    integer::igs,ige,ricon
    real*8 :: mp ! a multiplier of the matrix for normalisation purposes 
    
end module variables 