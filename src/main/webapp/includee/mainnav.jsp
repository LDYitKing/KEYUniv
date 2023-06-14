<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="mainnav__inner">

    <!-- Navigation menu -->
    <div class="mainnav__top-content scrollable-content pb-5">

        <!-- Profile Widget -->
        <div class="mainnav__profile mt-3 d-flex3">

            <div class="mt-2 d-mn-max"></div>

            <!-- Profile picture  -->
            <div class="mininav-toggle text-center py-2">
                <img class="mainnav__avatar img-md rounded-circle border" src="${cPath}/resources/assets/img/profile-photos/1.png" alt="Profile Picture">
            </div>

            <div class="mininav-content collapse d-mn-max">
                <div class="d-grid">

                    <!-- User name and position -->
                    <button class="d-block btn shadow-none p-2" data-bs-toggle="collapse" data-bs-target="#usernav" aria-expanded="false" aria-controls="usernav">
                        <span class="d-flex justify-content-center align-items-center">
                            <h6 class="mb-0 me-0">김열심 <small>학생</small></h6>
                        </span>
                        <small class="text-muted">컴퓨터공학과</small>
                    </button>

                    <!-- Collapsed user menu -->

                </div>
            </div>

        </div>
        <!-- End - Profile widget -->

        <div class="mainnav__categoriy py-3">
            <h6 class="mainnav__caption mt-0 px-3 fw-bold">Link Items</h6>
            <ul class="mainnav__menu nav flex-column">

                <li class="nav-item">
                    <a href="#" class="nav-link mininav-toggle collapsed"><i class="pli-bar-chart fs-5 me-2"></i>
                        <span class="nav-label mininav-content ms-1">Regular</span>
                    </a>
                </li>

                <li class="nav-item">
                    <a href="#" class="nav-link mininav-toggle collapsed active"><i class="pli-home fs-5 me-2"></i>
                        <span class="nav-label mininav-content ms-1">Active state</span>
                    </a>
                </li>

                <li class="nav-item">
                    <a href="#" class="nav-link mininav-toggle collapsed"><i class="pli-brush fs-5 me-2"></i>
                        <span class="nav-label mininav-content ms-1 fw-bold">Bolder link</span>
                    </a>
                </li>

                <li class="nav-item">
                    <a href="#" class="nav-link mininav-toggle collapsed">
                        <i class="pli-roller fs-5 me-2"></i>
                        <span class="nav-label mininav-content ms-1 flex-fill">
                            <span class="d-flex flex-row w-100">
                                Badge <span class="badge bg-info ms-auto">NEW</span>
                            </span>
                        </span>
                    </a>
                </li>

            </ul>
        </div>

        <div class="mainnav__categoriy py-3">
            <h6 class="mainnav__caption mt-0 px-3 fw-bold">Submenus</h6>
            <ul class="mainnav__menu nav flex-column">

                <li class="nav-item has-sub">

                    <a href="#" class="mininav-toggle nav-link">
                        <i class="pli-data-center fs-5 me-2"></i>
                        <span class="nav-label ms-1">Submenu</span>
                    </a>

                    <ul class="mininav-content nav collapse">
                        <li class="nav-item">
                            <a href="#" class="nav-link">Submenu Items</a>
                        </li>
                        <li class="nav-item">
                            <a href="#" class="nav-link">Submenu Items</a>
                        </li>
                        <li class="nav-item">
                            <a href="#" class="nav-link">Submenu Items</a>
                        </li>
                    </ul>

                </li>

                <li class="nav-item has-sub">

                    <a href="#" class="mininav-toggle nav-link active">
                        <i class="pli-idea fs-5 me-2"></i>
                        <span class="nav-label ms-1">Active Item</span>
                    </a>

                    <ul class="mininav-content nav collapse">
                        <li class="nav-item">
                            <a href="#" class="nav-link">Submenu Items</a>
                        </li>
                        <li class="nav-item">
                            <a href="#" class="nav-link active">Active state</a>
                        </li>
                        <li class="nav-item">
                            <a href="#" class="nav-link">Submenu Items</a>
                        </li>
                    </ul>

                </li>

                <li class="nav-item has-sub">

                    <a href="#" class="mininav-toggle nav-link">
                        <i class="pli-pizza-slice fs-5 me-2"></i>
                        <span class="nav-label ms-1">Badge</span>
                    </a>

                    <ul class="mininav-content nav collapse">
                        <li class="nav-item">
                            <a href="#" class="nav-link">Submenu Items</a>
                        </li>
                        <li class="nav-item">
                            <a href="#" class="nav-link">Submenu Items</a>
                        </li>
                        <li class="nav-item">
                            <a href="#" class="nav-link d-flex align-items-center">
                                Badge
                                <span class="badge bg-danger ms-auto">NEW</span>
                            </a>
                        </li>

                    </ul>

                </li>

            </ul>
        </div>

        <div class="mainnav__categoriy py-3">
            <h6 class="mainnav__caption mt-0 px-3 fw-bold">Multi Level</h6>
            <ul class="mainnav__menu nav flex-column">
                <li class="nav-item has-sub">

                    <a href="#" class="mininav-toggle nav-link collapsed"><i class="pli-tactic fs-5 me-2"></i>
                        <span class="nav-label ms-1">Menu Levels</span>
                    </a>

                    <ul class="mininav-content nav collapse">
                        <li class="nav-item">
                            <a href="#" class="nav-link">Menu Link</a>
                        </li>
                        <li class="nav-item">
                            <a href="#" class="nav-link">Menu Link</a>
                        </li>
                        <li class="nav-item">
                            <a href="#" class="nav-link">Menu Link</a>
                        </li>
                        <li class="nav-item has-sub">
                            <a href="#" class="mininav-toggle nav-link collapsed">Submenu</a>
                            <ul class="mininav-content nav collapse">
                                <li class="nav-item">
                                    <a href="#" class="nav-link">Menu Link</a>
                                </li>
                                <li class="nav-item">
                                    <a href="#" class="nav-link">Menu Link</a>
                                </li>
                                <li class="nav-item">
                                    <a href="#" class="nav-link">Menu Link</a>
                                </li>
                                <li class="nav-item">
                                    <a href="#" class="nav-link">Menu Link</a>
                                </li>
                            </ul>
                        </li>
                        <li class="nav-item has-sub">
                            <a href="#" class="mininav-toggle nav-link collapsed">Submenu</a>
                            <ul class="mininav-content nav collapse">
                                <li class="nav-item">
                                    <a href="#" class="nav-link">Menu Link</a>
                                </li>
                                <li class="nav-item">
                                    <a href="#" class="nav-link">Menu Link</a>
                                </li>
                                <li class="nav-item">
                                    <a href="#" class="nav-link">Menu Link</a>
                                </li>
                                <li class="nav-item">
                                    <a href="#" class="nav-link">Menu Link</a>
                                </li>
                            </ul>
                        </li>
                    </ul>

                </li>
            </ul>
        </div>

        <!-- Widget -->
        <div class="mainnav__profile">

            <!-- Widget buttton form small navigation -->
            <div class="mininav-toggle text-center py-2 d-mn-min">
                <i class="pli-monitor-2"></i>
            </div>

            <div class="d-mn-max mt-5"></div>

            <!-- Widget content -->
            <div class="mininav-content collapse d-mn-max">
                <h6 class="mainnav__caption px-3 fw-bold">Server Status</h6>
                <ul class="list-group list-group-borderless">
                    <li class="list-group-item text-reset">
                        <div class="d-flex justify-content-between align-items-start">
                            <p class="mb-2 me-auto">CPU Usage</p>
                            <span class="badge bg-info rounded">35%</span>
                        </div>
                        <div class="progress progress-md">
                            <div class="progress-bar bg-info" role="progressbar" style="width: 35%" aria-label="CPU Progress" aria-valuenow="35" aria-valuemin="0" aria-valuemax="100"></div>
                        </div>
                    </li>
                    <li class="list-group-item text-reset">
                        <div class="d-flex justify-content-between align-items-start">
                            <p class="mb-2 me-auto">Bandwidth</p>
                            <span class="badge bg-warning rounded">73%</span>
                        </div>
                        <div class="progress progress-md">
                            <div class="progress-bar bg-warning" role="progressbar" style="width: 73%" aria-label="Bandwidth Progress" aria-valuenow="73" aria-valuemin="0" aria-valuemax="100"></div>
                        </div>
                    </li>
                </ul>
                <div class="d-grid px-3 mt-3">
                    <a href="#" class="btn btn-sm btn-success">View Details</a>
                </div>
            </div>
        </div>
        <!-- End - Profile widget -->

    </div>
    <!-- End - Navigation menu -->

    <!-- Bottom navigation menu -->
    <div class="mainnav__bottom-content border-top pb-2">
        <ul id="mainnav" class="mainnav__menu nav flex-column">
            <li class="nav-item has-sub">
                <a href="#" class="nav-link mininav-toggle collapsed" aria-expanded="false">
                    <i class="pli-unlock fs-5 me-2"></i>
                    <span class="nav-label ms-1">Logout</span>
                </a>
                <ul class="mininav-content nav flex-column collapse">
                    <li class="nav-item">
                        <a href="#" class="nav-link">This device only</a>
                    </li>
                    <li class="nav-item">
                        <a href="#" class="nav-link">All Devices</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link disabled" href="#" tabindex="-1" aria-disabled="true">Lock screen</a>
                    </li>
                </ul>
            </li>
        </ul>
    </div>
    <!-- End - Bottom navigation menu -->

</div>