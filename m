Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C131624DD
	for <linux-hardening@vger.kernel.org>; Mon, 14 Jul 2025 00:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752454225; cv=none; b=UIsrd0cTHuD5CYT6hnLq4dIDgjTaSYWjkUZZ4exOP7Cf2engjtgCC9RSWwQYYzOA19q+GNn6eS71L+HA8zweFejbZrzAKLTwVJ4hZtffu/2o00GXKBs/fHtZuBQL3Y8zYcIHRZ3kaG3ufGQlrh0DImBRA2aX3wxBJEXsefdxSH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752454225; c=relaxed/simple;
	bh=/7EXQJB73/5gvIoUTG6KNRo3AVFSgdFix2K94IEW4HE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Sr/VitZaGSR5oG7ciwBm+f6DN0PSOjmlYYzLt4oqifbFyg4QK0ksLpINM2evHrb/R+jdLa1ZMmb2fszXFT6Px6Vhl0owIAep31yIlocAfgYTGCENL9yqQH62/ZvGGvwFQfVLWkN/74vJeKQ7/h6+g5A/o6Z1qD/m7QdHWcA7qOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=p09MScsi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="p09MScsi"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56DNPPYu032000
	for <linux-hardening@vger.kernel.org>; Mon, 14 Jul 2025 00:50:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QvkKKmGa22ueSGt3EngA9F+r5r19tnVaQ1z09ewqLKU=; b=p09MScsiKDK6DM53
	DAhUDQah5I2Tl5ACEoaNgdyS6NZ/0wIoRefyau03Qni+RzdH1KEER4tGq1nqa40x
	EbkkEk8Nwss6S7LhrSG8y5n4oN80pno/CHHeBJFBTT6FgthVy0nUvL6pZWU84vlO
	TllYBfcetWPomThXp/zDDvx3Mwv6du03PAaGpkL2USJhl5s9PNTye1lbwzLg4Ctc
	AuJro/wV5g4Ef+ugpqwnJuqrz2ARrzmpAdCMatd+IlnAXa2+BRfk8pJdc1KatU9x
	umOdGQ9sj7P7LcigSSYZXJDQ7gsJPHMJrx9e1ovA7w4dlFdRLqkFl7uxhMPFDXfY
	/Hryfg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ugvmtsqd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Mon, 14 Jul 2025 00:50:22 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2369261224bso43012985ad.0
        for <linux-hardening@vger.kernel.org>; Sun, 13 Jul 2025 17:50:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752454221; x=1753059021;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QvkKKmGa22ueSGt3EngA9F+r5r19tnVaQ1z09ewqLKU=;
        b=sWCu82FvipERM1ysIwafdAfhyy7EvKb66XqysJ1Ab9DHVcQoKibJvzY53smIv6JVRG
         DBQNIGFIY4LwRZUe+9k9DSnmmQKe7hWUX2Q5+rOJviQX7UeT0ALGjYB7wZoWLXZYnjSu
         Wn5EccsEDoiRAs0IBT86lzL9w1pwgPqtdLbKglIdsOAqqJzh6JYjLb6rm+sPUl49Oadu
         hhoJ0cQ/77Bh4ynpXaauldtGoTqviPgYkemsH2owkFiA+z5SnWxu7zsejnhmVcmQEvC0
         YQaeZZzZS55APfeqoAL62Xbc95SFR/gbV+3pDPz76VeXQSHdfljNl2VnfL0N6JaD3/u+
         mU7Q==
X-Forwarded-Encrypted: i=1; AJvYcCW3KO7ZfeKDie3qIEvH1olaHu29nKk0Ta7A/DtWTFv3rDHp7wILDTl+NdOw+i4hq5EUufGijz929aBqaLwAgvk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSqhlbxKKIB4zKYrS7vt/z8fHbHU3uO4RQ6v6oackekmlahstn
	1aqqPEeZr/yPNuH5mn6Ak59UtPVTNRNt3P/GaIh8UDWx2uXG2t/poKKjY5eHdYsHJW/qZZjK7nl
	L5vhZNT7hcsS3QNuSCLDBKsQvh/s7xz0Wj+CdBUsPgqz7eYCdLR5ydvCjrp3W3r3hOncf5w==
X-Gm-Gg: ASbGnculvJdQB3CLBu+UqiMwfqg0PbZ8TlFYoj/mLJqn3AooJwGSgDVW8N6DZpN9FrS
	LkbVZuGcT/rRNuRbByqejD08Zu7nbgMdKvTqXH9sJQHYtclRnOwMorb/3ae9thk9i4MVslhAZDK
	XPVb6oUGyRha5bwiFeAhn+WTAHBVgx0o2pbN4UBU1ot4VHzK3M9G3muEyFHrd8CcDsNEp/MJ6b+
	EmDg4pldwQ2EIPE8JsrGp0amxhYNfQeTJoGcX2DoknOamV8kCRmNarSJPMvDLcXe/sN+hqtm+0L
	YuHjih8guJGOm2OWowcdK80dfWQULeaxlRpM3fPOGOtKZnrGL9PPxleWO0ERH6UDhwH1bNaXQn4
	3E54Vf31zU2vN27/PGoOG/3U=
X-Received: by 2002:a17:902:cf0e:b0:235:f078:473e with SMTP id d9443c01a7336-23dee262fb5mr193358355ad.43.1752454221413;
        Sun, 13 Jul 2025 17:50:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5X0qUNlSCOYZOXc+6fFe7qW/RjprPxFG+s/k+fDKrAs5f5Q2JYKfn8YqH6S388QYdLFb30A==
X-Received: by 2002:a17:902:cf0e:b0:235:f078:473e with SMTP id d9443c01a7336-23dee262fb5mr193357925ad.43.1752454220976;
        Sun, 13 Jul 2025 17:50:20 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de428473fsm87562605ad.13.2025.07.13.17.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 17:50:20 -0700 (PDT)
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Date: Sun, 13 Jul 2025 17:49:14 -0700
Subject: [PATCH v6 02/12] tee: add close_context to TEE driver operation
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250713-qcom-tee-using-tee-ss-without-mem-obj-v6-2-697fb7d41c36@oss.qualcomm.com>
References: <20250713-qcom-tee-using-tee-ss-without-mem-obj-v6-0-697fb7d41c36@oss.qualcomm.com>
In-Reply-To: <20250713-qcom-tee-using-tee-ss-without-mem-obj-v6-0-697fb7d41c36@oss.qualcomm.com>
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
X-Proofpoint-GUID: 8xlwWndQg-8KFH3umVfVUiQtjk4TYsMo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDAwMiBTYWx0ZWRfX2hAGTmvbERJF
 dFNvjgL8M9GcG4pO+woooK1viQhf5EpOEtIgt2ONXo2XxIwCjHwUuCjQLFfOjb7h5kMUqbNdtq+
 nfpm+jZf/bLhBSv2wzg+y1/hr1PaW2V3YnKdzqP0BN7cJlfViRPWbSzhXMnRxzRsbKH/4P6cEXi
 a8XfS9KWVKNjV207bh0klYlEdlwYrlv5Z33YjKhWBZZW/p5yHuQuc5VN10Nhd4uYmEfaHuzEm8/
 9MSY6fxjsLlyjJCCu2It/k2lsAJlu2dKi+Yhu43oOP4EWii592R3qRjgXdd1bgULaa9LrPTwSw1
 chBdbK1v7wH0UFRyGVOlnjze6kirvo6ESREoPjgwJF7YkbwPLXHHIRo/YOCZB4tU+Y3Cp+czbvr
 5RiUFPNm2OO6iECjoDnPOSij+uhi1ZB6W18I1hpmLFx6ZgrH4jWtZvTCYu0yhFWfjYFxif/1
X-Proofpoint-ORIG-GUID: 8xlwWndQg-8KFH3umVfVUiQtjk4TYsMo
X-Authority-Analysis: v=2.4 cv=C4fpyRP+ c=1 sm=1 tr=0 ts=6874544e cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=COk6AnOGAAAA:8 a=0l_YNDiMcOfTHwIteTYA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-13_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 mlxscore=0 suspectscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507140002

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
index 133447f25065..b9ea5a85278c 100644
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

