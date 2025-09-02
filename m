Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4053A14A9B
	for <linux-hardening@vger.kernel.org>; Tue,  2 Sep 2025 04:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756788975; cv=none; b=N8NQt8Bt4azj1NArObmsgCCzDsiR792DcAJ+EufIaE28N/buLarZGzbhbMpUD0Zs9fg8KE2l90rr+g2uopskfdW/zayp2PxWEIov4Ho985L4uy2SKhZZ3BsBOWA5C5Gqt57XbX58Txq0+4uEiyFrwGWj9NUGTw/hziotCPqCueI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756788975; c=relaxed/simple;
	bh=1jm04ES+asCVZba6oF25bP65sA07cELqrfz4UPNNrDU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hE+SgthvBPGAbM44EqmQU8cnWuBXhz+sX58noHz7B68s7QI+ghJnVKxbQaPuE+XiCeJ1RkR+87ot4aG2HxZF+KPFTS/lzNsSRWBfk0zvrLqrFoTHOVKSxKLFkUZ99yLenKnOvPnwx+fuS8o4fB4WAj35tU7hA0NnfhbZ0wjIdS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cVReKvd1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cVReKvd1"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822XG2h031614
	for <linux-hardening@vger.kernel.org>; Tue, 2 Sep 2025 04:56:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Pb44B9mvSZygdGxuiUZdX1
	i7STOb6kc/CKsVwWfZH0U=; b=cVReKvd1dqUqsw15sz8AJM3+J06B9S0EgXy1ou
	TxmEYusCyjsFrW+I7/i+qTPaVTAOKS3knANgFV1rxpNmStzIzz5rX7LaN61iAdSS
	dEQf36qXCWmp5kjNZnETBqPNBcSUCdFcvc/Tf71eSKZNdK0sR4vi18QV4JY0dSog
	NXM1L1S2e7dFkMoCA2W0Vxn8etUXlKwefXBc6kXpbSWxoBWv56dcdIfVbCk9GZEM
	SO0BKUkdAcoBwiktt9JT7tOwIKS887kWzk1y/it/6K29tcIezc1eQvoV8tHZG2YZ
	fZGMJipCDOcZJfQVfhtr1zms0jkGirP1tV1CgV5squuHfU4w==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48wqvw89c3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Tue, 02 Sep 2025 04:56:12 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-24ae30bd2d0so13150725ad.3
        for <linux-hardening@vger.kernel.org>; Mon, 01 Sep 2025 21:56:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756788971; x=1757393771;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pb44B9mvSZygdGxuiUZdX1i7STOb6kc/CKsVwWfZH0U=;
        b=et3jCB1AvpSJvEyrAYpGCMLpWdSyPMmCcwrJJXL7tNEF5MmaR502IPjcJljP1K06Z9
         mQW1mA44Mx3wJhCTOCmq1m7hweGrGg8GOHWlae7FdhbA4Zr76AFbwIVMLueb76I1NZ4A
         Oq7zCtaL8Ocq7szgV09Dt5j4Ffu5k4y+NchQQwl+g1aXwlmeQjOSfSijsX0pphKwg/KZ
         bVGC24HYf9otQoPTdqO8Zre1ivqqTsSMzW4eCCVUrgis/N9gU8gsf69EqEhMe863jMbH
         QRM7q31YYduZ46KMEwhHMfiRpEyTUwj+Beyqbw6cHf4le07R4jNC8ezULkBKjOKE6xRl
         sz5w==
X-Forwarded-Encrypted: i=1; AJvYcCV493FQ8RcOTtx/KCr//lrzb9JpgYDKeSwai14dW3ZNkA9CU/O4nnoQW1KsP4ADhzrYLHeCAl4aDBOUzHJNXL8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+/WoBY2i0xW57IbdVAktgcU58yELUXyJSywoCy2m7lgCo5XCQ
	L5jF/717HEoR6cfG74/EqSH00bGe0nfDBc/jwSP9MkgrrJCdpN/9UZpPpPS5Mk/vrQha9ItKtN1
	XiASc1o9m2caDTIRdcs5wajT+xVMYOUH3Z45z+mbmpBIxE/oYrEztCG4RAgwPHABqwvyBCw==
X-Gm-Gg: ASbGnctnwEuP+Ot7sdY/0YKX/XNPcICN+qvqE62eTmMpovWj4Qjjq1/d8E2MamHom7X
	jfpo8ODlfjIG+etHD31v7vmqL68vdHYIISlTCsIqTxiclXHLGg63a3825CYu1QjNmpGsFRBTyOt
	iN+yN/gR6iy0jddgATmkIcEse8Umu9wMaAG8n0tPaRfTCWDBy37RuW3cCpsfMmGIoxPxjcj2tG3
	TWlykJj/w70xKVy8f+9lhNtJtwFIgUE2fqYB09IDZ3hoM8asFFh2pjq8O94GhT1ZXXMAZ7+t38r
	rD5ngs+v+05U2ybOdIALWPFxJSlso9WkWR2rlCgYDS4hsSYcztISRppfv6PTlwSmmpA1vaFVw/X
	yDvdk/dUFsEseX5CrMB3jTac=
X-Received: by 2002:a17:903:120a:b0:240:99e6:6bc3 with SMTP id d9443c01a7336-249448e65c6mr133199945ad.20.1756788971291;
        Mon, 01 Sep 2025 21:56:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECjLxnxxPtKLsUOp8pYTE5tuAvJf9zYyRjoJLi0S79dSZBrXNBltpoJIhZ084Sja7iYiQJIQ==
X-Received: by 2002:a17:903:120a:b0:240:99e6:6bc3 with SMTP id d9443c01a7336-249448e65c6mr133199475ad.20.1756788970646;
        Mon, 01 Sep 2025 21:56:10 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24b1f30a63asm1795345ad.66.2025.09.01.21.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 21:56:10 -0700 (PDT)
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Subject: [PATCH v9 00/11] Trusted Execution Environment (TEE) driver for
 Qualcomm TEE (QTEE)
Date: Mon, 01 Sep 2025 21:55:47 -0700
Message-Id: <20250901-qcom-tee-using-tee-ss-without-mem-obj-v9-0-a2af23f132d5@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANN4tmgC/5XRwWrEIBAG4FdZPNdFRzNjetr3KD0Yo7uWJmlik
 rYs++41CyWFNpBexBHn+wfmypIfok/s8XBlg59jil2bi/LhwNzFtmfPY51rBgK0zAfvXdfw0Xs
 +pdie77eU+HscL9008sY3vKteuEJwiEqLAohl623wIX7cc56ec32JaeyGz3vsLJfX/ybMkgseC
 gE+COmFxFM/RRdbd8ztbMmY4dvNv/a7kF0oyVtXi1rp8NtVq6uA9roquxR0QYIUGKhPXUrHfrK
 vub1Zcb3iGsxeXGccrdQKtbDoqg28WPECcC9eZDwvxysAWYmq3MBxxUmqvTguk5cUKqq1dAo3c
 FpxI3fvkjLuPFlpibQRagM3P3AQe3GzLFQgohFBKmP/wG+32xfaeK6zYgMAAA==
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
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kuldeep Singh <quic_kuldsing@quicinc.com>
X-Mailer: b4 0.13.0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAyMDAyNCBTYWx0ZWRfXxbWqsbQ13DfW
 1NwoqE6hOdoW+pAnQaIH6baZGYap9Ah8OOt3qLybVEuqatmhUUO5rvqYj8YuPe6A0FhG8GxBevw
 Q/ndvJXIkTW/G3lZn62pH5JV8A3w5S0+IU4BTDf/NTvDtzv/c8aYnGgF8zPHrVN42MmKMTynX75
 6rwrp2KgdCXr3eXTFGXdznXcZ6tSQcy4vIKoaev4JF42u8gl5CJWiZUGnsslw1C+O1zz8J1tcIB
 L0dRom43L6l6t5k+JgdRQvUGpqSjW6FvJ8ATpyadbLEVscWGQR+/GxVZFR3f2fyYd/JExOpx4td
 aJ9p6p4x1pxDHYmlCPTLeTZwZ+hd4VkV6wPkcrgUTJZ9y0UgFBA0Med1cIrIvdky4Rbds54W4w3
 nX48EH/L
X-Authority-Analysis: v=2.4 cv=WKh/XmsR c=1 sm=1 tr=0 ts=68b678ec cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=hlSAHII3iifkWu_GNqkA:9
 a=xUDI22gMzfwWuP27:21 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 6iV1qoKvyZpbXN18MyDJVNmE8_ZWV_eD
X-Proofpoint-ORIG-GUID: 6iV1qoKvyZpbXN18MyDJVNmE8_ZWV_eD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 phishscore=0 adultscore=0
 spamscore=0 malwarescore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509020024

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

More comprehensive tests are availabe at
https://github.com/qualcomm/minkipc.

root@qcom-armv8a:~# qtee_supplicant &
root@qcom-armv8a:~# qtee_supplicant: process entry PPID = 378
Total listener services to start = 4
Opening CRequestTABuffer_open
Path /data/
register_service ::Opening CRegisterTABufCBO_UID
Calling TAbufCBO Register
QTEE_SUPPLICANT RUNNING
 
root@qcom-armv8a:~# smcinvoke_client -c /data 1
Run callback obj test...
Load /data/tzecotestapp.mbn, size 52192, buf 0x1e44ba0.
System Time: 2024-02-27 17:26:31
PASSED - Callback tests with Buffer inputs.
PASSED - Callback tests with Remote and Callback object inputs.
PASSED - Callback tests with Memory Object inputs.
TEST PASSED!
root@qcom-armv8a:~#
root@qcom-armv8a:~# smcinvoke_client -m /data 1
Run memory obj test...
Load /data/tzecotestapp.mbn, size 52192, buf 0x26cafba0.
System Time: 2024-02-27 17:26:39
PASSED - Single Memory Object access Test.
PASSED - Two Memory Object access Test.
TEST PASSED!

This series has been tested for QTEE object invocations, including
loading a TA, requesting services from the TA, memory sharing, and
handling callback requests to a supplicant.

Tested platforms: sm8650-mtp, sm8550-qrd, sm8650-qrd, sm8650-hdk

[1] https://www.kernel.org/doc/Documentation/tee.txt

Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

Changes in v9:
- Remove unnecessary logging in qcom_scm_probe().
- Replace the platform_device_alloc()/add() sequence with
  platform_device_register_data().
- Fixed sparse warning.
- Fixed documentation typo.
- Link to v8:
  https://lore.kernel.org/r/20250820-qcom-tee-using-tee-ss-without-mem-obj-v8-0-7066680f138a@oss.qualcomm.com

Changes in v8:
- Check if arguments to qcom_scm_qtee_invoke_smc() and
  qcom_scm_qtee_callback_response() are NULL.
- Add CPU_BIG_ENDIAN as a dependency to Kconfig.
- Fixed kernel bot errors.
- Link to v7:
  https://lore.kernel.org/r/20250812-qcom-tee-using-tee-ss-without-mem-obj-v7-0-ce7a1a774803@oss.qualcomm.com

Changes in v7:
- Updated copyrights.
- Updated Acked-by: tags.
- Fixed kernel bot errors.
- Link to v6:
  https://lore.kernel.org/r/20250713-qcom-tee-using-tee-ss-without-mem-obj-v6-0-697fb7d41c36@oss.qualcomm.com

Changes in v6:
- Relocate QTEE version into the driver's main service structure.
- Simplfies qcomtee_objref_to_arg() and qcomtee_objref_from_arg().
- Enhanced the return logic of qcomtee_object_do_invoke_internal().
- Improve comments and remove redundant checks.
- Improve helpers in qcomtee_msh.h to use GENMASK() and FIELD_GET().
- updated Tested-by:, Acked-by:, and Reviewed-by: tags
- Link to v5:
  https://lore.kernel.org/r/20250526-qcom-tee-using-tee-ss-without-mem-obj-v5-0-024e3221b0b9@oss.qualcomm.com

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
Amirreza Zarrabi (11):
      tee: allow a driver to allocate a tee_device without a pool
      tee: add close_context to TEE driver operation
      tee: add TEE_IOCTL_PARAM_ATTR_TYPE_UBUF
      tee: add TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF
      tee: increase TEE_MAX_ARG_SIZE to 4096
      firmware: qcom: scm: add support for object invocation
      firmware: qcom: tzmem: export shm_bridge create/delete
      tee: add Qualcomm TEE driver
      tee: qcom: add primordial object
      tee: qcom: enable TEE_IOC_SHM_ALLOC ioctl
      Documentation: tee: Add Qualcomm TEE driver

 Documentation/tee/index.rst              |   1 +
 Documentation/tee/qtee.rst               |  96 ++++
 MAINTAINERS                              |   7 +
 drivers/firmware/qcom/qcom_scm.c         | 124 +++++
 drivers/firmware/qcom/qcom_scm.h         |   7 +
 drivers/firmware/qcom/qcom_tzmem.c       |  63 ++-
 drivers/tee/Kconfig                      |   1 +
 drivers/tee/Makefile                     |   1 +
 drivers/tee/qcomtee/Kconfig              |  12 +
 drivers/tee/qcomtee/Makefile             |   9 +
 drivers/tee/qcomtee/async.c              | 182 ++++++
 drivers/tee/qcomtee/call.c               | 820 +++++++++++++++++++++++++++
 drivers/tee/qcomtee/core.c               | 915 +++++++++++++++++++++++++++++++
 drivers/tee/qcomtee/mem_obj.c            | 169 ++++++
 drivers/tee/qcomtee/primordial_obj.c     | 113 ++++
 drivers/tee/qcomtee/qcomtee.h            | 185 +++++++
 drivers/tee/qcomtee/qcomtee_msg.h        | 304 ++++++++++
 drivers/tee/qcomtee/qcomtee_object.h     | 316 +++++++++++
 drivers/tee/qcomtee/shm.c                | 150 +++++
 drivers/tee/qcomtee/user_obj.c           | 692 +++++++++++++++++++++++
 drivers/tee/tee_core.c                   | 127 ++++-
 drivers/tee/tee_private.h                |   6 -
 include/linux/firmware/qcom/qcom_scm.h   |   6 +
 include/linux/firmware/qcom/qcom_tzmem.h |  15 +
 include/linux/tee_core.h                 |  54 +-
 include/linux/tee_drv.h                  |  12 +
 include/uapi/linux/tee.h                 |  56 +-
 27 files changed, 4415 insertions(+), 28 deletions(-)
---
base-commit: 33bcf93b9a6b028758105680f8b538a31bc563cf
change-id: 20241202-qcom-tee-using-tee-ss-without-mem-obj-362c66340527

Best regards,
-- 
Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

