Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35191FCF7C
	for <linux-hardening@vger.kernel.org>; Tue, 27 May 2025 06:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748329044; cv=none; b=TTp5hMCsuCcWUtRhmvdKS4tctVvGk1lRnu/f+wmKHUIv/3uRIVcBtMsvUbsFOMHjKXjFaae4rpnKunMxD+FCeN34rb0JhJ2QJ55mCd5MPjIr8Gh1oTiYYVlNdaCfBp+a3z41fmoX8btCJ/s9Nftu8HKxFl0c5U6QMrmbFiq6Veo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748329044; c=relaxed/simple;
	bh=utl3UjzIhfO9pDpRJSg8RxvUjfVVuBH6Koxgz507w8Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=J34/+dB7HpCRTrzwUeKgdCftNWHi7A5QxHXXuEEOwVdAHNtj/Km0KmMHVhP3+ZL42oWMMbnaE2+/H8Cz9duxelw+o5T1UANaCWAJ8jl0yfMvAUSWUhunZTFguQD/6ZryVuukepfig5c9UQuplPjymbvyMwkpy0P47XXSqDpVRp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MSfV867V; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MSfV867V"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54R4JepN012264
	for <linux-hardening@vger.kernel.org>; Tue, 27 May 2025 06:57:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=R/XXNjqqqmQQ2nBiWKgZ1m
	TILSavzSgd6ug36jOlfis=; b=MSfV867VdhsCNe0rGUbEtX/PvyT5LkhMrb4fZJ
	TuQ6t78H6Rz7c+O2LhlM3nuQKGzln9EHnlk3PfDmYddMLwRHoXurMwi/VEVQ+XS0
	WpRAyv9+NM8FP+L/NBozkfIXOE8rOjvJn58jrKAk+n5gui/ByMNZ5FOkDo5U6HAb
	neC4+KJbIqdc0s2MxrJ+WMGnQwBk3WfBdHQAzspyVzukh5pIe+jHrHRdnGulpd8I
	MAFvAb4Ah7UucGXmGjTLL9RaMHFi3wcvpbnyVOahgJFB0UA8Pc7Odzg9Paj+g6VI
	jDijS8jPxozCeDdJTA3UjqrVmL9X1KcRFjQJRkVM3Tl/eibw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46w6918atv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Tue, 27 May 2025 06:57:16 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7425efba1a3so2509220b3a.0
        for <linux-hardening@vger.kernel.org>; Mon, 26 May 2025 23:57:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748329035; x=1748933835;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R/XXNjqqqmQQ2nBiWKgZ1mTILSavzSgd6ug36jOlfis=;
        b=m/GISffBHOGy0qbhO5zUAXmQ/j/h8UHOrSElxROF5fXisCOKc9crUpC/gEacMe2PPo
         x+1quaE9SxJT8xDb0zPFIgHgDslxJqcdicyVYLb8fTYYsrnByWm66+yD7bwzCzO/0YHk
         A3NI91R3Pnz3a9JR133Sipt9T/0NK/EyHNiWdfewYy1w64ACyUW/1z9pnJ0y7WQLX4Ha
         kfJcvDwwWcenCpbzm8kO3w0Zs9Pgembz6DFlOcMcKzwYQbwARm71erRcwA/Kw5dcddXU
         qtK+3sFUz8YJe6nS4MSdcYR/a81HjH11LjIdvUELbtK+EBqHEm9G8hxdvRypNLfK0/0f
         xgvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXb++B6HmIdiCbrZdm8W0iAiTzKoNUvNDmZ8D5QmczILmFYW7S62fJNYAT2YYnhmSHb0qMMbmcDLIoHgnc3TrE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyztJLm803SUxFM5lT/IP3MUfjieBQo/H0Ky4hbaeRkxDZIqeZw
	Mp9JLNI5Z+wLJZVfp8M8lzzFNwQFI4ZGQpm5HHEQdZXWznJkd9+TiRjW5orzO08o1CiOTS30F+c
	DkbPGU2sOPeKWYC572oHq0DoxFw57Hxt9O8+tWxkHhu9TKe79YxIBufOjgtj8tt49g0iEKw==
X-Gm-Gg: ASbGncuE49v72iYSQ6MrqGHKy8F3QRAG/8X7cjz+EUnBCzz7B3N/lI87OQ2kLaj2+D7
	1+DImCKmFZa7OkQa3IfacL5uiXP6KFycKdwkJILoHObU/SDND5M/7iJ2I7VivSToe3ldE8PFHsl
	7Aqypsoza0QRY76uyCesyv7k5bWBu7EnbF8uDFyK7RjUOaySOi01bTQbH54LSVQEmhGXESr6Jkz
	9haVyo9Iw3ARluKHvENm2WPEgtiCKMk/I3wRJvhHipYwMi8OnLXBwZ4S4YYfgDGIgIXSj1xCc57
	6bUhzj92BBDqhor+IUAzy7vIceFIXbGhAuzw+DaWO3yNVTlJ6GPwmx6WQhGJf/D7bWygbv8=
X-Received: by 2002:a62:f24d:0:b0:746:2217:5863 with SMTP id d2e1a72fcca58-7462217598emr3300913b3a.6.1748329035369;
        Mon, 26 May 2025 23:57:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZrfcH3Sb55ANTjm+eWz4bJbtObaXuc1t3YV5MjNkK73rAKu9ia6cV/91JxIDr6Urj8Gki2g==
X-Received: by 2002:a62:f24d:0:b0:746:2217:5863 with SMTP id d2e1a72fcca58-7462217598emr3300873b3a.6.1748329034886;
        Mon, 26 May 2025 23:57:14 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a970954asm18037286b3a.46.2025.05.26.23.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 23:57:14 -0700 (PDT)
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Subject: [PATCH v5 00/12] Trusted Execution Environment (TEE) driver for
 Qualcomm TEE (QTEE)
Date: Mon, 26 May 2025 23:56:45 -0700
Message-Id: <20250526-qcom-tee-using-tee-ss-without-mem-obj-v5-0-024e3221b0b9@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC1iNWgC/5XNwU7DMAwG4FeZcsZT4qTJ4LT3QByy1FmDaEObt
 oCmvjteJdQDHMrF8h/F338ThYZERTwdbmKgOZWUOw7Vw0GExndXglRzFijRKB7Qh9zCSARTSd1
 13UqBjzQ2eRqhpRby5RW0xWCtNrJCJ9h6Hyimz7Xn+YVzk8qYh6+1dlb31/82zAokxEoiRalIK
 nvupxRSF458Lu4dM/64/Gu/i+zioyMfallrE3+7enM1ur2uZtdFUznpNJ6wPudSjv3k3/i83XC
 z4QZPe3HDuPXKaGukt+HyB74syzdaoFNc7gEAAA==
To: Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Apurupa Pattapu <quic_apurupa@quicinc.com>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org,
        Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Sumit Garg <sumit.garg@oss.qualcomm.com>,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.13.0
X-Authority-Analysis: v=2.4 cv=WfoMa1hX c=1 sm=1 tr=0 ts=6835624c cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=wdamrMJRu_bT6IjY2ZgA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 27wrVJbqLmgVjVLcMnaxuFY3AC0jIGS-
X-Proofpoint-ORIG-GUID: 27wrVJbqLmgVjVLcMnaxuFY3AC0jIGS-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI3MDA1NCBTYWx0ZWRfX6f/TrSO+krd8
 +1a+HiD6mlt5VP8irwWGpWJ0ZqoyG1wVHRvbp9QuSBdIgQ0a+6tiMfvk6KJ99VktU3cIWg5ao1u
 0vQ0Cv2N68MIxDKEQpO/F81ISYSqFAG7y4yRywAUhI7bv5ggAd+sjSlCV5j1GA7u7hon750GB6s
 5yrfcpxWFZ1CqNpgKOmcQXUqCW/Y2m3D1NitNCm9Xlxr3Xw0aLHlT2RyCWBQ2HT35UQlOGg8iln
 +w++3lly/hhPnl1z//eRSMT/hozLDNvDAoP0Why3061pM1cCG1H08JfSbgDaWtlIKmqkWYmQkZp
 nuRNcDOvz1gz3dpm41QcESVtAzBvMH8frsizzFIbHVWqISnGVPERB+S+DhysUg9XPHLUijxTCkT
 r+s/Lp/5juVafEoELfTiDTYWh6gzhHTtRd4HvcCxaGyahZd+9UAuBFfXGZDcP/UgVdHF0B6E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_03,2025-05-26_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0
 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505270054

This patch series introduces a Trusted Execution Environment (TEE)
driver for Qualcomm TEE (QTEE). QTEE enables Trusted Applications (TAs)
and services to run securely. It uses an object-based interface, where
each service is an object with sets of operations. Clients can invoke
these operations on objects, which can generate results, including other
objects. For example, an object can load a TA and return another object
that represents the loaded TA, allowing access to its services.

Kernel and userspace services are also available to QTEE through a
similar approach. QTEE makes callback requests that are converted into
object invocations. These objects can represent services within the
kernel or userspace process.

Note: This patch series focuses on QTEE objects and userspace services.

Linux already provides a TEE subsystem, which is described in [1]. The
tee subsystem provides a generic ioctl interface, TEE_IOC_INVOKE, which
can be used by userspace to talk to a TEE backend driver. We extend the
Linux TEE subsystem to understand object parameters and an ioctl call so
client can invoke objects in QTEE:

  - TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_*
  - TEE_IOC_OBJECT_INVOKE

The existing ioctl calls TEE_IOC_SUPPL_RECV and TEE_IOC_SUPPL_SEND are
used for invoking services in the userspace process by QTEE.

The TEE backend driver uses the QTEE Transport Message to communicate
with QTEE. Interactions through the object INVOKE interface are
translated into QTEE messages. Likewise, object invocations from QTEE
for userspace objects are converted into SEND/RECV ioctl calls to
supplicants.

The details of QTEE Transport Message to communicate with QTEE is
available in [PATCH 12/12] Documentation: tee: Add Qualcomm TEE driver.

You can run basic tests with following steps:
git clone https://github.com/quic/quic-teec.git
cd quic-teec
mkdir build
cmake .. -DCMAKE_TOOLCHAIN_FILE=CMakeToolchain.txt -DBUILD_UNITTEST=ON

https://github.com/quic/quic-teec/blob/main/README.md lists dependencies
needed to build the above.

This series has been tested for basic QTEE object invocations and
callback requests, including loading a TA and requesting services form
the TA.

Tested platforms: sm8650-mtp, sm8550-qrd, sm8650-qrd, sm8650-hdk

[1] https://www.kernel.org/doc/Documentation/tee.txt

Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

Changes in v5:
- Remove references to kernel services and public APIs.
- Support auto detection for failing devices (e.g., RB1, RB4).
- Add helpers for obtaining client environment and service objects.
- Query the QTEE version and print it.
- Move remaining static variables, including the object table, to struct
  qcomtee.
- Update TEE_MAX_ARG_SIZE to 4096.
- Add a dependancy to QCOM_TZMEM_MODE_SHMBRIDGE in Kconfig
- Reorganize code by removing release.c and qcom_scm.c.
- Add more error messages and improve comments.
- updated Tested-by:, Acked-by:, and Reviewed-by: tags
- Link to v4: https://lore.kernel.org/r/20250428-qcom-tee-using-tee-ss-without-mem-obj-v4-0-6a143640a6cb@oss.qualcomm.com

Changes in v4:
- Move teedev_ctx_get/put and tee_device_get/put to tee_core.h.
- Rename object to id in struct tee_ioctl_object_invoke_arg.
- Replace spinlock with mutex for qtee_objects_idr.
- Move qcomtee_object_get to qcomtee_user/memobj_param_to_object.
- More code cleanup following the comments.
- Cleanup documentations.
- Update MAINTAINERS file.
- Link to v3: https://lore.kernel.org/r/20250327-qcom-tee-using-tee-ss-without-mem-obj-v3-0-7f457073282d@oss.qualcomm.com

Changes in v3:
- Export shm_bridge create/delete APIs.
- Enable support for QTEE memory objects.
- Update the memory management code to use the TEE subsystem for all
  allocations using the pool.
- Move all driver states into the driver's main service struct.
- Add more documentations.
- Link to v2: https://lore.kernel.org/r/20250202-qcom-tee-using-tee-ss-without-mem-obj-v2-0-297eacd0d34f@quicinc.com

Changes in v2:
- Clean up commit messages and comments.
- Use better names such as ubuf instead of membuf or QCOMTEE prefix
  instead of QCOM_TEE, or names that are more consistent with other
  TEE-backend drivers such as qcomtee_context_data instead of
  qcom_tee_context.
- Drop the DTS patch and instantiate the device from the scm driver.
- Use a single structure for all driver's internal states.
- Drop srcu primitives and use the existing mutex for synchronization
  between the supplicant and QTEE.
- Directly use tee_context to track the lifetime of qcomtee_context_data.
- Add close_context() to be called when the user closes the tee_context.
- Link to v1: https://lore.kernel.org/r/20241202-qcom-tee-using-tee-ss-without-mem-obj-v1-0-f502ef01e016@quicinc.com

Changes in v1:
- It is a complete rewrite to utilize the TEE subsystem.
- Link to RFC: https://lore.kernel.org/all/20240702-qcom-tee-object-and-ioctls-v1-0-633c3ddf57ee@quicinc.com

---
Amirreza Zarrabi (12):
      tee: allow a driver to allocate a tee_device without a pool
      tee: add close_context to TEE driver operation
      tee: add TEE_IOCTL_PARAM_ATTR_TYPE_UBUF
      tee: add TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF
      tee: increase TEE_MAX_ARG_SIZE to 4096
      firmware: qcom: scm: add support for object invocation
      firmware: qcom: scm: remove unused arguments to the shm_brige
      firmware: qcom: tzmem: export shm_bridge create/delete
      tee: add Qualcomm TEE driver
      qcomtee: add primordial object
      qcomtee: enable TEE_IOC_SHM_ALLOC ioctl
      Documentation: tee: Add Qualcomm TEE driver

 Documentation/tee/index.rst              |   1 +
 Documentation/tee/qtee.rst               | 150 +++++
 MAINTAINERS                              |   8 +
 drivers/firmware/qcom/qcom_scm.c         | 132 ++++-
 drivers/firmware/qcom/qcom_scm.h         |   7 +
 drivers/firmware/qcom/qcom_tzmem.c       |  57 +-
 drivers/tee/Kconfig                      |   1 +
 drivers/tee/Makefile                     |   1 +
 drivers/tee/qcomtee/Kconfig              |  11 +
 drivers/tee/qcomtee/Makefile             |   9 +
 drivers/tee/qcomtee/async.c              | 183 ++++++
 drivers/tee/qcomtee/call.c               | 833 +++++++++++++++++++++++++++
 drivers/tee/qcomtee/core.c               | 930 +++++++++++++++++++++++++++++++
 drivers/tee/qcomtee/mem_obj.c            | 172 ++++++
 drivers/tee/qcomtee/primordial_obj.c     | 116 ++++
 drivers/tee/qcomtee/qcomtee.h            | 266 +++++++++
 drivers/tee/qcomtee/qcomtee_msg.h        | 251 +++++++++
 drivers/tee/qcomtee/qcomtee_object.h     | 309 ++++++++++
 drivers/tee/qcomtee/shm.c                | 150 +++++
 drivers/tee/qcomtee/user_obj.c           | 694 +++++++++++++++++++++++
 drivers/tee/tee_core.c                   | 127 ++++-
 drivers/tee/tee_private.h                |   6 -
 include/linux/firmware/qcom/qcom_scm.h   |  10 +-
 include/linux/firmware/qcom/qcom_tzmem.h |  15 +
 include/linux/tee_core.h                 |  54 +-
 include/linux/tee_drv.h                  |  12 +
 include/uapi/linux/tee.h                 |  56 +-
 27 files changed, 4528 insertions(+), 33 deletions(-)
---
base-commit: 3be1a7a31fbda82f3604b6c31e4f390110de1b46
change-id: 20241202-qcom-tee-using-tee-ss-without-mem-obj-362c66340527

Best regards,
-- 
Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

