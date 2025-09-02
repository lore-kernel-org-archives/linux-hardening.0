Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E5C2E173E
	for <linux-hardening@vger.kernel.org>; Tue,  2 Sep 2025 04:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756788980; cv=none; b=ui3aQ+/mCRoYgFu/12+tJRQDiI2QPDdLiFXMeZWdBTicPdOV+rn++skpNIwafidkqPXOVqENeXlW4XIL5UvUaIUEwg0mfjxhvaknVNPip8JjfnD94jkE6wCEKzZ0+iy+lODy42PPtPjMJ8SE7+5lWcV4fndvAlWxr9ZxNT3t+mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756788980; c=relaxed/simple;
	bh=8TSbhEgUPN9kdxwy9KCMFyUVP58G/S0fhvuvLlT55sU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YaTxGBEnv2PsLySw7UHPmcTo8GLdeOcGM11vFp5/OKWNMQc7tYPK51jqPoL+QEAhmKG9AJ1Vc4Owq8k3A+ajDFYO2XfHY7t5pl74AOfV0y6U4MY0o+9DfTZ6x/Swf5uzByTI5ucm+JF9VwB4rjj8isjtJO2j+m8PwFo4TUTDJ68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iIfFW0I3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iIfFW0I3"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822SH6b010488
	for <linux-hardening@vger.kernel.org>; Tue, 2 Sep 2025 04:56:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kjXvseb+vxS0ErbDImEwiyaXgCwIyoxRM6Sfo6q8WkU=; b=iIfFW0I32F92zUsI
	ILJcSCTxOouSkhrRJRtciOCFo+pa9+ynYfOrU/YFKKBXVqSjskCGgGmnqfVgZ1vw
	WOp9aMSHyyEUjG7uiWJ9oomm9Me1CEcig5uhb/jbEZY+5EsS0nz/uy+/52npY7GA
	EPQ8PfQs7HUfCAzs/MOZejO/VJfhqMAH0M4j9cqJBV03saN9bGCetvmPvy3TQOHz
	rlrFYwS3oGlJD2E0kIeD9+6KoeRZ3jtPFR2g3c69XwiScq9AGnh9/GVz3Vkg009v
	OrJ8tBCyT+6KDYybgECBw4sUZzb/9HzFeA0zISw2h/ARoL3fgzkVFv83O8jgrD12
	3K/3yQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urmjehnr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Tue, 02 Sep 2025 04:56:16 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-249118cb74cso39050475ad.0
        for <linux-hardening@vger.kernel.org>; Mon, 01 Sep 2025 21:56:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756788975; x=1757393775;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kjXvseb+vxS0ErbDImEwiyaXgCwIyoxRM6Sfo6q8WkU=;
        b=pSiyVOzWMamGnDpteSaGhTvUGVC1cqnRIGT0JtQv4AEKU92NGBBDsdNwq9rKCEkT+m
         ZcuRE1ytjMImidO6lMoQR+2nUAiEqdoMGujv3opWJECVcm8lCBTaCvzZw8NZV2W4gtu0
         RQPqp469BXNe9RmquILufzst9h01v5I8gakC98WZ1aoQVUptGHbTQ69iyk+u8aqKVPa+
         uvOqVluETErfTYwqgJV92JTqG+deW0ZVdzYZdbXHYftHykXDCAnYpNSMDlZGpBcvC4+j
         UgvQ2AWDEcIO7kdxAYoJa/6b7l79xhTNNNLHhidm3Jaw5Z7gspwfC19XKvb3OWi+KoA7
         BRDg==
X-Forwarded-Encrypted: i=1; AJvYcCVLVeGdo1qItvIZOK/gpJsKjQIKHXzx7qRhfMN+SKlzJSHpJBnSCIXeieZ3Dte4hGhg8k07wfdgr2jrHRl02LQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1zRytIPcYbO8V9FLeLg530LvRf6GSi0mPag5qufWz5ZJSJUqm
	ptwbfUfmrN90hiyEZgNwSixAheT4WZ4cWI1jKjdXjr6SnZq0TVVOLKtVG4hhcLXgoqCveQeJxhx
	hPUt3VaZ70nt+P2I8drIJLs6pq6IrzPrDw4sZnZrRZflwrqH+O+hpajOuFRvkF5Zfj7vTyg==
X-Gm-Gg: ASbGncsU1WWwEm17ozK/KVzvzxgyKsjPqZr3pG65Wct4Qcr9S/baEBGQJ0uDrGa2k4H
	yN9XEMP8rkgzeWTgFLDwxldbEfBCEJF3qo52shKDFdVBmOmhkh62puoN4epeUebKg+klkxkn4Pc
	E2Oy9PZex/fXsEfQ4c6pkQfmf6ptemUUD3BcK1z0Rt+W9/OimkDDUfIT4txwDHSTL+B7mil4n2/
	jy9+ahJExkE3cgkgKaVU851mQ/VurW3eueN2B7CmC87zIg3ZLnWlqrw+ItG9POOsbGrQGmgRq8A
	hYyRfkr4Gj3bQ3G12fQOhNhFGnDdcrW8SKyyMrNWszXCUfgBU/3KVf60jOGcH5FhHFkSRE570Ci
	zK518wQce2Eont3ZV+s7dDwA=
X-Received: by 2002:a17:902:e751:b0:246:b467:eea9 with SMTP id d9443c01a7336-249448f7469mr129860565ad.21.1756788974339;
        Mon, 01 Sep 2025 21:56:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH77S9mvbvLIaovZEBD4/4yt6zu0c+XmESSaejKdDoCP87UwUTgmY3MMpN0CUVuhTsR1O0bwQ==
X-Received: by 2002:a17:902:e751:b0:246:b467:eea9 with SMTP id d9443c01a7336-249448f7469mr129860145ad.21.1756788973822;
        Mon, 01 Sep 2025 21:56:13 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24b1f30a63asm1795345ad.66.2025.09.01.21.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 21:56:13 -0700 (PDT)
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Date: Mon, 01 Sep 2025 21:55:49 -0700
Subject: [PATCH v9 02/11] tee: add close_context to TEE driver operation
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250901-qcom-tee-using-tee-ss-without-mem-obj-v9-2-a2af23f132d5@oss.qualcomm.com>
References: <20250901-qcom-tee-using-tee-ss-without-mem-obj-v9-0-a2af23f132d5@oss.qualcomm.com>
In-Reply-To: <20250901-qcom-tee-using-tee-ss-without-mem-obj-v9-0-a2af23f132d5@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=OemYDgTY c=1 sm=1 tr=0 ts=68b678f0 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=COk6AnOGAAAA:8 a=0l_YNDiMcOfTHwIteTYA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: Zmvn3kDZUqE7QxiDczMzvq4qIUtQdVBT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNCBTYWx0ZWRfX6aPuKQSzYKXS
 94f8rbELSYXV6saIitqwG0XoUraSwljCtyFH14LSM11po7WecrB5Mi3bwgDGdPU02q2RhIFSg7L
 NyFQmLi9IGG1bJf7DUDjzmVlLRXwkGklwbuMGlWX/thusaYWT+tQGnDSsrZQb7utDG0ld1tX0hs
 v04KMVxGsAFAVAYjgNVqsDnRDDgeSi6eWJv+Czuw2oehAu12tn3EsxKp/myC+T5S/YaqCriFdKi
 SqKYGFXeGowlxKAXh5PdODabhP2BZaBMk7AUgLBffSTyiREPeb0H+Iih7Ig/XqSWYz+KBBG05PI
 jtqlRjbHc/OLL3D5UoV1soqAlwsCe09isuvmOQLK5lke7DxniBmBCl4q8T2mIF9x0Bw/7tk5AX5
 QSkoCpVF
X-Proofpoint-ORIG-GUID: Zmvn3kDZUqE7QxiDczMzvq4qIUtQdVBT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300024

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
index 33091aa21be0..0b4c65dc14cc 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -79,6 +79,7 @@ void teedev_ctx_get(struct tee_context *ctx)
 
 	kref_get(&ctx->refcount);
 }
+EXPORT_SYMBOL_GPL(teedev_ctx_get);
 
 static void teedev_ctx_release(struct kref *ref)
 {
@@ -96,11 +97,15 @@ void teedev_ctx_put(struct tee_context *ctx)
 
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
@@ -1001,6 +1006,7 @@ void tee_device_put(struct tee_device *teedev)
 	}
 	mutex_unlock(&teedev->mutex);
 }
+EXPORT_SYMBOL_GPL(tee_device_put);
 
 bool tee_device_get(struct tee_device *teedev)
 {
@@ -1013,6 +1019,7 @@ bool tee_device_get(struct tee_device *teedev)
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

