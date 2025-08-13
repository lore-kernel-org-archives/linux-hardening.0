Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB362746A
	for <linux-hardening@vger.kernel.org>; Wed, 13 Aug 2025 00:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755045426; cv=none; b=KZZqN3R1Obemap8GriPGnn7XOvgkCYMRU7VshEB6avZE5lNVKdUcPx/R0HqDtOyu1sIgGDgYEeds4gf5LVIPtcKBTjWV9B/UdHj/PZlKmHVJwS1ODREeL9KaBpjTKE1tID7QISpGx4hCEe5vVuooF6gMqSX5jseymVsiHRk3/CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755045426; c=relaxed/simple;
	bh=MFrqGNTPT4AoV3VaCoEubJQ7khypQPxY9UTqtUk9UBw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RGTJb+1CMJgZ9rnRWa1dOC4zwypoVqzv88EeyYFQTi04ximdTdSJYJ4o9sKGWqNXIlDR9LORjitR6sqAS3r6cHRtc+I8UyaURlNYPU4RfuynBFaJg4Yr+8JEgxAD5C2q1xWm7PET2Buye3D7n6dgvJSM9lCcELUTS6Graid9rH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OaEN4QjC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OaEN4QjC"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CJjb0O012358
	for <linux-hardening@vger.kernel.org>; Wed, 13 Aug 2025 00:37:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SZkIak/CnogNIohVjfrGy7vKdxiGWC4sl5fGDKdZ1SU=; b=OaEN4QjCehCWwHsM
	hK3AMmhwuWjG9rB+I/eMzSo75T/wzOmzky81Bc1I3BuuE/B6eeo/EenIXS+gvU83
	5m0Hs0Jtwpo9qmURHPk4878Bhy7tvuUnfckf9xRYHLn62ifKOUruAaukiF43l6js
	1wo4EWRoKcxm5gsNhpm3o+MQmf+2aHDV+MBmYKjXa1g2rFu3Rmbg7s9VMFDS8Kjq
	XGXr9zxWP6FNUqLxn5u5Ngky4UwkutxAk2aMfjGJ6arUi4WJlERSqk6EH3r5ND1m
	pN7FOcqd+rbWBaNtTz7VvfZQPbmu62Yr5RqhUF9mjNQ6ITLRKx/d74+m9fRpqruG
	0T2mIg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dxdv1vkk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Wed, 13 Aug 2025 00:37:03 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2400cbd4241so96179165ad.3
        for <linux-hardening@vger.kernel.org>; Tue, 12 Aug 2025 17:37:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755045422; x=1755650222;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SZkIak/CnogNIohVjfrGy7vKdxiGWC4sl5fGDKdZ1SU=;
        b=aPSHT0Vdzr02HtefkbUfHpqP0ty7iisJgOEnprcMwaRXzUp454fnvC1rpXS8++sqgp
         G5KCh3BkCacgVTuRntqMGKxnD0+QPHaa5Iv2sAGjli7dvdnHS/b6/OWAhnEXJz23xZ6p
         yYNasKksK6bsYGqM2RLvMzykBUluXZFnJLt1PXeAFuPBFjmiGNON8zZF/i1JzD2AZSv4
         tESOZYqCROoheoDsvXhDJMH+0sKmtQx4TIH24EDzheGeZhrL8Au+FHwp8Ukm0rvPJaTF
         SfcI8s34GWShyumOGEQa+cEh+mnob+rCPZmt8UxjLk1xsvdHhx45MQ7Y2ooSMHuN+euj
         0U3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXC25iiifZ4+u3kLb2owoPVIZmlK3BDhJhCZ5cMZnBUe651juJVjs3N4pLIUq6AEsL46kyTNTp3L2LHmqDzKSs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhQ6+vdI8dnDBDYk+uuyvA3e8hljQafFAENHJzcyVlg3lDGHga
	hrok5+zLCAlykdatTNtlx2rzCXT+nPny48bTdQKa9QoDksPtauXrfqfeIo+buIT1/2B3jeZWQ2h
	3dJERYajtKxL5QNt30OV6dB3qDDr2i7hnFLE6U+KvyNMMAWLY9QzwDC2GJ65lIL/sAFW7xPN9eZ
	CLtCgA
X-Gm-Gg: ASbGncsxQmvCpcF5CsCbcirEYuwAXds6J1w9fGl8UkHl6Pt/Z5v0UJfFU+pYAYJrNUT
	Ifiou1WecmfnhBUgLg6x9XjA1GT2LkVtq0vzR6TKwZrA+PTReZEz/VDiTxhqHccr//5CQGZsPlX
	HCtiImw0A56TWWYe36d2nFlURVFiEz4oRLvht0v0DZ7Z+bkjlXS6iV7Ta2G9IeikN71C7AsvGTW
	tm57jMSDd7RF1NfAtUJPvMMf0YhcQZLWRmo2OVE3GnQ4fRHHiKDjY+q4tOhd/Xg7gfS8ySEjsdV
	+26KMXn2EZqLl0vo9h2QQ6U04mPEUmncT66xmE/k3tXfcRIT6J7s0ZuHKSrOK1NB95IPIjENVXa
	LeBbhZCoCfgbeTgnS9kK3z3o=
X-Received: by 2002:a17:903:3c2c:b0:243:597:a2f0 with SMTP id d9443c01a7336-2430d108278mr16376015ad.23.1755045422414;
        Tue, 12 Aug 2025 17:37:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVTMGkjD367YhdbNapUwz7Z2X26qEDvXBYUGX4tepkb2C88xT8Wd/R5MHkhv4Ew7ZpY4TkfQ==
X-Received: by 2002:a17:903:3c2c:b0:243:597:a2f0 with SMTP id d9443c01a7336-2430d108278mr16375545ad.23.1755045421827;
        Tue, 12 Aug 2025 17:37:01 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8975c89sm308781585ad.96.2025.08.12.17.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 17:37:01 -0700 (PDT)
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Date: Tue, 12 Aug 2025 17:35:31 -0700
Subject: [PATCH v7 02/11] tee: add close_context to TEE driver operation
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-qcom-tee-using-tee-ss-without-mem-obj-v7-2-ce7a1a774803@oss.qualcomm.com>
References: <20250812-qcom-tee-using-tee-ss-without-mem-obj-v7-0-ce7a1a774803@oss.qualcomm.com>
In-Reply-To: <20250812-qcom-tee-using-tee-ss-without-mem-obj-v7-0-ce7a1a774803@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=IuYecK/g c=1 sm=1 tr=0 ts=689bde2f cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=COk6AnOGAAAA:8 a=0l_YNDiMcOfTHwIteTYA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: j4lCxZmitjo5iG6t5cCXxmjLRS7_CmT5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAyNSBTYWx0ZWRfXzIbk/rg253SZ
 X+LKugwHSQReUesuqCWunhnqU9amL2sp1SyB5Wjo65BSF4Zt3ETb3VihU8bk9LKUxMBEWslaTBQ
 NSy/z5nMYw2JxnOz8B9B5pR62FAYkgd9RgB9NfxOBcCOedDF5zuLXvkHIdijWPKUSFeQYr80R52
 xlbKtfqmLkRrrPjBMC9dBQAavsDEKlI5EJsnJk3E1Cdsz4As03hqoFZdH2IdQAg6DA8PZNE/cpN
 yIuhfmIDJ/jUgpd5nc1vs5yEFRuPhSE7iP1x/+klFzYczM3GNUHUPS+MRhBr7hr9Eprbd6tIoeF
 AkV/RHUMvmHlkASpnwR9qRss3Ao/o4qmSkPVzRFjPH8F1R5VgRw2jTtxSew31aZZ0vgyCvAcFdo
 cJYvWVNj
X-Proofpoint-GUID: j4lCxZmitjo5iG6t5cCXxmjLRS7_CmT5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_08,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 phishscore=0 suspectscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090025

The tee_context can be used to manage TEE user resources, including
those allocated by the driver for the TEE on behalf of the user.
The release() callback is invoked only when all resources, such as
tee_shm, are released and there are no references to the tee_context.

When a user closes the device file, the driver should notify the
TEE to release any resources it may hold and drop the context
references. To achieve this, a close_context() callback is
introduced to initiate resource release in the TEE driver when
the device file is closed.

Relocate teedev_ctx_get, teedev_ctx_put, tee_device_get, and
tee_device_get functions to tee_core.h to make them accessible
outside the TEE subsystem.

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
Tested-by: Harshal Dev <quic_hdev@quicinc.com>
Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
---
 drivers/tee/tee_core.c    |  7 +++++++
 drivers/tee/tee_private.h |  6 ------
 include/linux/tee_core.h  | 50 +++++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 55 insertions(+), 8 deletions(-)

diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index e47a68d337b4..a2b365bcee51 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -80,6 +80,7 @@ void teedev_ctx_get(struct tee_context *ctx)
 
 	kref_get(&ctx->refcount);
 }
+EXPORT_SYMBOL_GPL(teedev_ctx_get);
 
 static void teedev_ctx_release(struct kref *ref)
 {
@@ -97,11 +98,15 @@ void teedev_ctx_put(struct tee_context *ctx)
 
 	kref_put(&ctx->refcount, teedev_ctx_release);
 }
+EXPORT_SYMBOL_GPL(teedev_ctx_put);
 
 void teedev_close_context(struct tee_context *ctx)
 {
 	struct tee_device *teedev = ctx->teedev;
 
+	if (teedev->desc->ops->close_context)
+		teedev->desc->ops->close_context(ctx);
+
 	teedev_ctx_put(ctx);
 	tee_device_put(teedev);
 }
@@ -1038,6 +1043,7 @@ void tee_device_put(struct tee_device *teedev)
 	}
 	mutex_unlock(&teedev->mutex);
 }
+EXPORT_SYMBOL_GPL(tee_device_put);
 
 bool tee_device_get(struct tee_device *teedev)
 {
@@ -1050,6 +1056,7 @@ bool tee_device_get(struct tee_device *teedev)
 	mutex_unlock(&teedev->mutex);
 	return true;
 }
+EXPORT_SYMBOL_GPL(tee_device_get);
 
 /**
  * tee_device_unregister() - Removes a TEE device
diff --git a/drivers/tee/tee_private.h b/drivers/tee/tee_private.h
index 9bc50605227c..d3f40a03de36 100644
--- a/drivers/tee/tee_private.h
+++ b/drivers/tee/tee_private.h
@@ -14,12 +14,6 @@
 
 int tee_shm_get_fd(struct tee_shm *shm);
 
-bool tee_device_get(struct tee_device *teedev);
-void tee_device_put(struct tee_device *teedev);
-
-void teedev_ctx_get(struct tee_context *ctx);
-void teedev_ctx_put(struct tee_context *ctx);
-
 struct tee_shm *tee_shm_alloc_user_buf(struct tee_context *ctx, size_t size);
 struct tee_shm *tee_shm_register_user_buf(struct tee_context *ctx,
 					  unsigned long addr, size_t length);
diff --git a/include/linux/tee_core.h b/include/linux/tee_core.h
index a38494d6b5f4..284ca6b3e03a 100644
--- a/include/linux/tee_core.h
+++ b/include/linux/tee_core.h
@@ -65,8 +65,9 @@ struct tee_device {
 /**
  * struct tee_driver_ops - driver operations vtable
  * @get_version:	returns version of driver
- * @open:		called when the device file is opened
- * @release:		release this open file
+ * @open:		called for a context when the device file is opened
+ * @close_context:	called when the device file is closed
+ * @release:		called to release the context
  * @open_session:	open a new session
  * @close_session:	close a session
  * @system_session:	declare session as a system session
@@ -76,11 +77,17 @@ struct tee_device {
  * @supp_send:		called for supplicant to send a response
  * @shm_register:	register shared memory buffer in TEE
  * @shm_unregister:	unregister shared memory buffer in TEE
+ *
+ * The context given to @open might last longer than the device file if it is
+ * tied to other resources in the TEE driver. @close_context is called when the
+ * client closes the device file, even if there are existing references to the
+ * context. The TEE driver can use @close_context to start cleaning up.
  */
 struct tee_driver_ops {
 	void (*get_version)(struct tee_device *teedev,
 			    struct tee_ioctl_version_data *vers);
 	int (*open)(struct tee_context *ctx);
+	void (*close_context)(struct tee_context *ctx);
 	void (*release)(struct tee_context *ctx);
 	int (*open_session)(struct tee_context *ctx,
 			    struct tee_ioctl_open_session_arg *arg,
@@ -154,6 +161,24 @@ int tee_device_register(struct tee_device *teedev);
  */
 void tee_device_unregister(struct tee_device *teedev);
 
+/**
+ * tee_device_get() - Increment the user count for a tee_device
+ * @teedev: Pointer to the tee_device
+ *
+ * If tee_device_unregister() has been called and the final user of @teedev
+ * has already released the device, this function will fail to prevent new users
+ * from accessing the device during the unregistration process.
+ *
+ * Returns: true if @teedev remains valid, otherwise false
+ */
+bool tee_device_get(struct tee_device *teedev);
+
+/**
+ * tee_device_put() - Decrease the user count for a tee_device
+ * @teedev: pointer to the tee_device
+ */
+void tee_device_put(struct tee_device *teedev);
+
 /**
  * tee_device_set_dev_groups() - Set device attribute groups
  * @teedev:	Device to register
@@ -315,4 +340,25 @@ struct tee_context *teedev_open(struct tee_device *teedev);
  */
 void teedev_close_context(struct tee_context *ctx);
 
+/**
+ * teedev_ctx_get() - Increment the reference count of a context
+ * @ctx: Pointer to the context
+ *
+ * This function increases the refcount of the context, which is tied to
+ * resources shared by the same tee_device. During the unregistration process,
+ * the context may remain valid even after tee_device_unregister() has returned.
+ *
+ * Users should ensure that the context's refcount is properly decreased before
+ * calling tee_device_put(), typically within the context's release() function.
+ * Alternatively, users can call tee_device_get() and teedev_ctx_get() together
+ * and release them simultaneously (see shm_alloc_helper()).
+ */
+void teedev_ctx_get(struct tee_context *ctx);
+
+/**
+ * teedev_ctx_put() - Decrease reference count on a context
+ * @ctx: pointer to the context
+ */
+void teedev_ctx_put(struct tee_context *ctx);
+
 #endif /*__TEE_CORE_H*/

-- 
2.34.1

