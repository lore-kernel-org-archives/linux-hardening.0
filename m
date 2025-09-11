Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523E52343B6
	for <linux-hardening@vger.kernel.org>; Thu, 11 Sep 2025 03:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757562089; cv=none; b=jb74pDusXwc2MVwQOY9qDj6RsnION5qmgsRjwEcI4SVm1C/Y6IFKHd6RcT3qDP8fgNMwnTqUnBx6WkaRuBo/uqNtXf8wcspzrR5sGndx4hUmf1kVYiR4+ta4QdAyYKmIGn6GxSYR5eX64IBM0AltZ1GOFoqVieUCvqrExK1zuHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757562089; c=relaxed/simple;
	bh=aheGNoOLEKJkUYHP/51nPevvJsceJ95yw8jOF/dS7Fs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LPWUhNFRJj8FE9ZMxO/rtpX27tZEHY2KdwY5TeVwVMsIorvraBkdFhp4A4aJfT4/x62ttz7Cb/WU3BOsVbyPim+hKIiK/YMQgL3LCXBeJxTa7PuXwfxhHG1TIJPtEpnUFmEez7NT4xCeTxu6ytreYP6sgsL1p6l3Veyhj14QQYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ACTLiRJ+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ACTLiRJ+"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58B2IUhR002273
	for <linux-hardening@vger.kernel.org>; Thu, 11 Sep 2025 03:41:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=bbBBMhrEsv7qNRzxrU8e8X
	M5/n7nt7EZOvuba+FCRVY=; b=ACTLiRJ+Zvy4113ynxQUei6fxkMHO/y0WdGAJZ
	WaxmWLN1muPG3nBGymCqQ7me5csE8Ru5/kWKjbUQXbPdE4a6SCYFUyCw3VDCfx1g
	fp0519IVcHx3JUY8IbhLdJk9gPBbGWLGNRs0uZQY/Rva/CNoMgl9ww2HnrjvwRy5
	SJx3eg2XJYvZE9L8wGm2/Rc/oc2cFElG9dLfSqaQo8vj2dUGr1hFeirMRo9SfD5v
	/bV+zRO5kj5rARoRyXMPGArEo1wGpe5PVowmdBaqgmD/NKFzZxxYf4jlkonNhgiC
	n1M2+sGvKv2z1NTIHUhDYWSau3zs65cRvgQJqzbT3IE2WCag==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490db8p5fy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Thu, 11 Sep 2025 03:41:25 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-32db3d5f205so423359a91.2
        for <linux-hardening@vger.kernel.org>; Wed, 10 Sep 2025 20:41:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757562084; x=1758166884;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bbBBMhrEsv7qNRzxrU8e8XM5/n7nt7EZOvuba+FCRVY=;
        b=nYehxTdn25E0tgfT2LddVQfl8OB+pHecFbKdJiTsTAZBULhRiDUS4z/v2m8jDKrXSO
         mbZ6Mxq5e6y5XXEwjkT+gv6v80xRoiPk/EKDnIcL9YjGlpscFvqrcnKkB2aJGgfgps6y
         pd91uGGFQZ6mKUhG+YYvqtNhN5U5FV2x+jnhgI5BbzZf98Pqo6oRBf83Vc+x4G2qf0nF
         MFp4WJWW9qTwt6z08FOORaVOXz2piqZtPcqf29HuRoeAxBAeqiS/M7vqgIAVQKlvi0mJ
         J/FJX5pdv3gyvyFnZhicVDUSvEEcOedk3fL4eCgArL35z0YsJ3wIuH/s+u+EpfPvvoA9
         qkwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxyC9xfdv54egxXPVjwSPJlmtG1f+Qul+xDkjAtdLdnbLryyl+MIEQppRkJN8vD+nkj3235fjR78IJrNHvG5o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoDKTcoEPo1dx85yurJA2Vqv6zUyDGDBCZvP4vMrB1ci5qHMbt
	VoNeuNFsb9K9pg6ApMujfmZf7SZLBvRoyRMFNbRocIKMIbifMbeDIzOloZ1xGfIhcj7r0qOrWRC
	kTnH30JefFwM96WY+Aqu/gYEied81XBmLSdsU3CwsxKiyBg/gzSI2Up7dqxY4jq6xFQPcaA==
X-Gm-Gg: ASbGncsfVoo6kYZH60iMwuv/7tYg8A0lv2BSfumZoMUK20YnFGlPbaI2Hum5vWy6AAw
	aY7z4WRbA0bmxAvdCXg/MX4XSvZwzV0xm3NJ/LfJhfIcUtH99qQHQV7rq08A3qPboBcAAa1t3lx
	Y+PkII0zEOXmq7XPROOVlzdRWLYtAk2b5eumTowCUT2hrqEPMBbAZsLn4pKkz0TPFd9ySra8w/j
	DGahRyupupTbnQgBaYrtuenb2X4RpkuAQ/wgdq/8l3txusEWUrbRw5OtCF8dPFAxgR1hd/3QtQg
	cDQzO6QXIXPtrT3BOlyRuzfDRHZ/gugAwNl9SwFZtpzL6tJgdBMw7eooGp1oXURrlgiw2QxIbGe
	SrYK39f5P+scc9f1nZZ1mIPI=
X-Received: by 2002:a17:902:d2d2:b0:24c:a269:b6d7 with SMTP id d9443c01a7336-25173119564mr235107495ad.50.1757562084072;
        Wed, 10 Sep 2025 20:41:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHA8qcHgo4cD6gRiRDNlWwY1szN/7aP4dEmiQtEyfRn8ayLHkhE0u89NwT6FLhgbuQXXpTNTw==
X-Received: by 2002:a17:902:d2d2:b0:24c:a269:b6d7 with SMTP id d9443c01a7336-25173119564mr235106915ad.50.1757562083355;
        Wed, 10 Sep 2025 20:41:23 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3b304f76sm2962275ad.130.2025.09.10.20.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 20:41:22 -0700 (PDT)
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Subject: [PATCH v11 00/11] Trusted Execution Environment (TEE) driver for
 Qualcomm TEE (QTEE)
Date: Wed, 10 Sep 2025 20:41:13 -0700
Message-Id: <20250910-qcom-tee-using-tee-ss-without-mem-obj-v11-0-520e867b3d74@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANpEwmgC/5XTzWrDMAwA4FcZOc9Fkn+zU99j7OA4duuxJmucZ
 Bul7z6nMFLYAt7FWML6ZJB9qZIfok/V08OlGvwcU+y7HCA+PlTuaLuDZ7HNiYqABOaFnV1/YqP
 3bEqxO9x2KbGPOB77aWQnf2J988q4IqcUFyBJV9l6H3yIn7dGzy85PsY09sPXre+MS/a/HWZkw
 IIE8gHQA6r9eYoudm6Xy6ulx0w/bj5V7lJ2qdbeuhZaLsJvl68uJ13q8uzqIKQGzclQu+9T2p0
 n+5bLTysuVlyQKcVFxpVFwZUAq1yzgcsVl6RKcZnxPBzPibCBpt7A1Ypr5KW4Wm5e69DoVqDja
 gPXK26weJY6485ri1ZrYYBv4OYOJyjFzTJQUEoZCMiN3cDrFa8BS/E645ZsIJ5tauUGjnCv18V
 /B5ZHDg1qI6UPHP/gr9frNxFrDd4fBAAA
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
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kuldeep Singh <quic_kuldsing@quicinc.com>,
        Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailer: b4 0.13.0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzMSBTYWx0ZWRfX6qGHf66j5zum
 8n/FgK8NcTevZ3J3GZJX++65qfXWlEqHtomQ4o7b6ycHp5y0ZLe15JkHjmskQTFHDzsVMqaUaRl
 bocKdMK1MSqvB5Lb+xxARlnNlc430ig1Ti2BNt60t1fP/HNG+EgIC+sC6tQZ9d67xbDakJn/rDa
 LVMdrHlmBSRJZiY/sQO0R/TpjDmjHHNv9JcQU79BAeKE9WrIhDwsKx27r4QzKE+hAUk5HofTyBe
 gRiKW/jIdowK4EqZU1z6m9FtFNLDkA/wkaEkZWuFIpm6UwLngC42ltZ8ZOPwkt5yu89LQkioJNl
 0M2/e5lHNhqlS6seAiXutTBMTG/nf0GkcgGQ2V27TSyKuKcdm0An6JCKUJRrAe8lHDb47q23qEV
 AUBMyLFR
X-Proofpoint-ORIG-GUID: Jj7v5exFV7jj-hZbV9kSwsmL8LyAR_7W
X-Proofpoint-GUID: Jj7v5exFV7jj-hZbV9kSwsmL8LyAR_7W
X-Authority-Analysis: v=2.4 cv=VIDdn8PX c=1 sm=1 tr=0 ts=68c244e5 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=hlSAHII3iifkWu_GNqkA:9
 a=huaRTxWe2eLa42Ba:21 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060031

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

Changes in v11:
- Rebased on next.
- Link to v10:
  https://lore.kernel.org/r/20250909-qcom-tee-using-tee-ss-without-mem-obj-v10-0-20b17855ef31@oss.qualcomm.com

Changes in v10:
- Remove all loggings in qcom_scm_qtee_init().
- Reorder patches.
- Link to v9:
  https://lore.kernel.org/r/20250901-qcom-tee-using-tee-ss-without-mem-obj-v9-0-a2af23f132d5@oss.qualcomm.com

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
      firmware: qcom: tzmem: export shm_bridge create/delete
      firmware: qcom: scm: add support for object invocation
      tee: allow a driver to allocate a tee_device without a pool
      tee: add close_context to TEE driver operation
      tee: add TEE_IOCTL_PARAM_ATTR_TYPE_UBUF
      tee: add TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF
      tee: increase TEE_MAX_ARG_SIZE to 4096
      tee: add Qualcomm TEE driver
      tee: qcom: add primordial object
      tee: qcom: enable TEE_IOC_SHM_ALLOC ioctl
      Documentation: tee: Add Qualcomm TEE driver

 Documentation/tee/index.rst              |   1 +
 Documentation/tee/qtee.rst               |  96 ++++
 MAINTAINERS                              |   7 +
 drivers/firmware/qcom/qcom_scm.c         | 119 ++++
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
 27 files changed, 4410 insertions(+), 28 deletions(-)
---
base-commit: 8b8aefa5a5c7d4a65883e5653cf12f94c0b68dbf
change-id: 20241202-qcom-tee-using-tee-ss-without-mem-obj-362c66340527

Best regards,
-- 
Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

