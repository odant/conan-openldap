find_path(OpenLDAP_INCLUDE_DIR
    NAMES ldap.h
    PATHS ${CONAN_INCLUDE_DIRS_OPENLDAP}
    NO_DEFAULT_PATH
)

find_library(OpenLDAP_ldap_LIBRARY
    NAMES ldap ldapd
    PATHS ${CONAN_LIB_DIRS_OPENLDAP}
    NO_DEFAULT_PATH
)

find_library(OpenLDAP_ldap_r_LIBRARY
    NAMES ldap_r ldap_rd
    PATHS ${CONAN_LIB_DIRS_OPENLDAP}
    NO_DEFAULT_PATH
)

find_library(OpenLDAP_lber_LIBRARY
    NAMES lber lberd
    PATHS ${CONAN_LIB_DIRS_OPENLDAP}
    NO_DEFAULT_PATH
)

find_library(OpenLDAP_lunicode_LIBRARY
    NAMES lunicode lunicoded
    PATHS ${CONAN_LIB_DIRS_OPENLDAP}
    NO_DEFAULT_PATH
)

find_library(OpenLDAP_lutil_LIBRARY
    NAMES lutil lutild
    PATHS ${CONAN_LIB_DIRS_OPENLDAP}
    NO_DEFAULT_PATH
)

find_library(OpenLDAP_rewrite_LIBRARY
    NAMES rewrite rewrited
    PATHS ${CONAN_LIB_DIRS_OPENLDAP}
    NO_DEFAULT_PATH
)

if(OpenLDAP_INCLUDE_DIR AND EXISTS ${OpenLDAP_INCLUDE_DIR}/portable.h)

    file(STRINGS ${OpenLDAP_INCLUDE_DIR}/portable.h DEFINE_OPENLDAP_MAJOR REGEX "^#define LDAP_VENDOR_VERSION_MAJOR")
    string(REGEX REPLACE "^.*VERSION_MAJOR +([0-9]+).*$" "\\1" OpenLDAP_VERSION_MAJOR "${DEFINE_OPENLDAP_MAJOR}")

    file(STRINGS ${OpenLDAP_INCLUDE_DIR}/portable.h DEFINE_OPENLDAP_MINOR REGEX "^#define LDAP_VENDOR_VERSION_MINOR")
    string(REGEX REPLACE "^.*VERSION_MINOR +([0-9]+).*$" "\\1" OpenLDAP_VERSION_MINOR "${DEFINE_OPENLDAP_MINOR}")

    file(STRINGS ${OpenLDAP_INCLUDE_DIR}/portable.h DEFINE_OPENLDAP_PATCH REGEX "^#define LDAP_VENDOR_VERSION_PATCH")
    string(REGEX REPLACE "^.*VERSION_PATCH +([0-9]+).*$" "\\1" OpenLDAP_VERSION_PATCH "${DEFINE_OPENLDAP_PATCH}")

    set(OpenLDAP_VERSION_STRING "${OpenLDAP_VERSION_MAJOR}.${OpenLDAP_VERSION_MINOR}.${OpenLDAP_VERSION_PATCH}")
    set(OpenLDAP_VERSION ${OpenLDAP_VERSION_STRING})
    set(OpenLDAP_VERSION_COUNT 3)

    unset(DEFINE_OPENLDAP_MAJOR)
    unset(DEFINE_OPENLDAP_MINOR)
    unset(DEFINE_OPENLDAP_PATCH)
    
    mark_as_advanced(OpenLDAP_VERSION_STRING OpenLDAP_VERSION OpenLDAP_VERSION_COUNT)
endif()

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(OpenLDAP
    REQUIRED_VARS
      OpenLDAP_INCLUDE_DIR
      OpenLDAP_ldap_LIBRARY
      OpenLDAP_ldap_r_LIBRARY
      OpenLDAP_lber_LIBRARY
      OpenLDAP_lunicode_LIBRARY
      OpenLDAP_lutil_LIBRARY
      OpenLDAP_rewrite_LIBRARY
    VERSION_VAR
      OpenLDAP_VERSION
)

if(OpenLDAP_FOUND)
    set(OpenLDAP_INCLUDE_DIRS ${OpenLDAP_INCLUDE_DIR})
    set(OpenLDAP_LIBRARIES 
        ${OpenLDAP_ldap_LIBRARY}
        ${OpenLDAP_ldap_r_LIBRARY}
        ${OpenLDAP_lber_LIBRARY}
        ${OpenLDAP_lunicode_LIBRARY}
        ${OpenLDAP_lutil_LIBRARY}
        ${OpenLDAP_rewrite_LIBRARY}
    )
    set(OpenLDAP_DEFINITIONS "${CONAN_COMPILE_DEFINITIONS_OPENLDAP}")
    
    if(NOT TARGET OpenLDAP::ldap_r) 
        add_library(OpenLDAP::ldap_r UNKNOWN IMPORTED)
        set_target_properties(OpenLDAP::ldap_r PROPERTIES
            INTERFACE_INCLUDE_DIRECTORIES ${OpenLDAP_INCLUDE_DIR}
            IMPORTED_LOCATION ${OpenLDAP_ldap_r_LIBRARY}
        )
        if (OpenLDAP_DEFINITIONS)
            set_property(TARGET OpenLDAP::ldap_r
                APPEND PROPERTY INTERFACE_COMPILE_DEFINITIONS ${OpenLDAP_DEFINITIONS}
            )
        endif()
    endif()

    if(NOT TARGET OpenLDAP::lber) 
        add_library(OpenLDAP::lber UNKNOWN IMPORTED)
        set_target_properties(OpenLDAP::lber PROPERTIES
            INTERFACE_INCLUDE_DIRECTORIES ${OpenLDAP_INCLUDE_DIR}
            IMPORTED_LOCATION ${OpenLDAP_lber_LIBRARY}
        )
        if (OpenLDAP_DEFINITIONS)
            set_property(TARGET OpenLDAP::lber
                APPEND PROPERTY INTERFACE_COMPILE_DEFINITIONS ${OpenLDAP_DEFINITIONS}
            )
        endif()
    endif()

    if(NOT TARGET OpenLDAP::lunicode) 
        add_library(OpenLDAP::lunicode UNKNOWN IMPORTED)
        set_target_properties(OpenLDAP::lunicode PROPERTIES
            INTERFACE_INCLUDE_DIRECTORIES ${OpenLDAP_INCLUDE_DIR}
            IMPORTED_LOCATION ${OpenLDAP_lunicode_LIBRARY}
        )
        if (OpenLDAP_DEFINITIONS)
            set_property(TARGET OpenLDAP::lunicode
                APPEND PROPERTY INTERFACE_COMPILE_DEFINITIONS ${OpenLDAP_DEFINITIONS}
            )
        endif()
    endif()

    if(NOT TARGET OpenLDAP::lutil) 
        add_library(OpenLDAP::lutil UNKNOWN IMPORTED)
        set_target_properties(OpenLDAP::lutil PROPERTIES
            INTERFACE_INCLUDE_DIRECTORIES ${OpenLDAP_INCLUDE_DIR}
            IMPORTED_LOCATION ${OpenLDAP_lutil_LIBRARY}
        )
        if (OpenLDAP_DEFINITIONS)
            set_property(TARGET OpenLDAP::lutil
                APPEND PROPERTY INTERFACE_COMPILE_DEFINITIONS ${OpenLDAP_DEFINITIONS}
            )
        endif()
    endif()

    if(NOT TARGET OpenLDAP::rewrite) 
        add_library(OpenLDAP::rewrite UNKNOWN IMPORTED)
        set_target_properties(OpenLDAP::rewrite PROPERTIES
            INTERFACE_INCLUDE_DIRECTORIES ${OpenLDAP_INCLUDE_DIR}
            IMPORTED_LOCATION ${OpenLDAP_rewrite_LIBRARY}
        )
        if (OpenLDAP_DEFINITIONS)
            set_property(TARGET OpenLDAP::rewrite
                APPEND PROPERTY INTERFACE_COMPILE_DEFINITIONS ${OpenLDAP_DEFINITIONS}
            )
        endif()
    endif()

    if(NOT TARGET OpenLDAP::ldap) 
        add_library(OpenLDAP::ldap UNKNOWN IMPORTED)
        set_target_properties(OpenLDAP::ldap PROPERTIES
            INTERFACE_INCLUDE_DIRECTORIES ${OpenLDAP_INCLUDE_DIR}
            IMPORTED_LOCATION ${OpenLDAP_ldap_LIBRARY}
        )
        set_property(
          TARGET OpenLDAP::ldap
          PROPERTY INTERFACE_LINK_LIBRARIES
          OpenLDAP::ldap_r OpenLDAP::lber OpenLDAP::lunicode OpenLDAP::lutil OpenLDAP::rewrite
        )        
        if (OpenLDAP_DEFINITIONS)
            set_property(TARGET OpenLDAP::ldap
                APPEND PROPERTY INTERFACE_COMPILE_DEFINITIONS ${OpenLDAP_DEFINITIONS}
            )
        endif()
    endif()

    mark_as_advanced(
      OpenLDAP_INCLUDE_DIR
      OpenLDAP_ldap_LIBRARY
      OpenLDAP_ldap_r_LIBRARY
      OpenLDAP_lber_LIBRARY
      OpenLDAP_lunicode_LIBRARY
      OpenLDAP_lutil_LIBRARY
      OpenLDAP_rewrite_LIBRARY
    )

endif()
