Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5420820E323
	for <linux-hardening@vger.kernel.org>; Fri, 28 Mar 2025 02:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743130118; cv=none; b=L2LRME274yWPdqbJ2gZ32ikh8bHle+MW5tWhwc/v+h/9d99Bfg3TAE077l05QyX4iYe6roxd20bcoig5vxJTjIaDFqMRGaY/PtCCaCE/Jyx+lRsijGE5P3iP/yZgKlRI+6ueYbGoLk2jtJQls+1DDejalEq4NOwIXJbaPI4dWPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743130118; c=relaxed/simple;
	bh=CDe5JhdOLLa/hqlVz4e5OYLU2O6X2NxJZ6fKQkq2Zto=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QjkXQIOb+uTW61/sQ6ydgpXH9Mw+j6bQAclDHiXjQwUuviJ7sDzX+fKtJ1JI7GNWRKK9iPyDWp2p6OMjpjmNzXU2oXRfD8Hqsu8vXhIRESdCeIQ7Ts5JL5nYthtvadoWXo58VqFucfkv0kS2ngXk9ySlQGUcC8HC0Uk0edRBL4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=puEq1l4w; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="puEq1l4w"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52REpGuB022987
	for <linux-hardening@vger.kernel.org>; Fri, 28 Mar 2025 02:48:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	K+Z35TzSeO8Nh9EpSjKhhJ9lhlYqB/2+MlDO7RYgw28=; b=puEq1l4wQPVa7joY
	TLkBaO+3oT3TP940recJBb4CsDgCzwcpnMJ1wvRxULvPsNS3FBezzTOmcgE1SZvR
	VhENbwmITljVHuIoqntPxL3zM7fKJsFWcyjiZO5J7KHpQ+n4jziGM62BOTLGxePD
	YJgMwGUqDLw+cltK+Y2JCscL5PvDTeJ4IksLuGv5RqO7AfTxVFPwFiLd/VKQ5YwF
	AzGeLQByUIwVRvrd5eF5iawp6/O40KmnLDEMf9xowst8m6AeCRtf/bXxC7yfvEdr
	jkPd/hcknDjJozGB5nY98uZEyzF8Ob2mVot7+8r0VidPw+M0FarEI0NjIQr/5A4j
	AJ5mNw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45mb9mxp43-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Fri, 28 Mar 2025 02:48:35 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2264e5b2b7cso30089575ad.2
        for <linux-hardening@vger.kernel.org>; Thu, 27 Mar 2025 19:48:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743130114; x=1743734914;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K+Z35TzSeO8Nh9EpSjKhhJ9lhlYqB/2+MlDO7RYgw28=;
        b=aZh1HftCZ4yrLM9kjV45umt/jk1ab47U6F2D5sFDXgYPodRMN2LgJZCn+5CBB3AR/7
         EYqT/xt9pNbzwW0ni5No27QZKu3qFf/M+todvFa+1SPyumOnR7Ji2uOLyIA/3TKUNb5w
         SrmYxcz19DNwwHFI5zkEkcoRGfAS7Ofiq/OM829FTzNK62iMLZfAPz/HfdIEh9geIdjk
         IgRxqrDcceetKm3tRgbkKVAmigpNwWyAC+2tbYy+ZvG7YqK1zix5wqbgVVBTdQ4Hu0mL
         YzR3Asu5PGXDuKS5nQOAAqaeo92mGXRQIKgDwlx87L1FomnrN7l9uxGnCqip1C0jKrPf
         rmwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdISQ4NCRuLzMQbHGwI7x9ZHaBwXvqdfEsz+FtUy2oJdya6PH7u7RQ0exktuDOMGyEKuIPLBl8d9Zh3+EvDQo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPSxvnBXnfNgLsv7gf1gqZdy3WNcHTZFavtXR51oHYy7GhMlh9
	IqI2kWsaazuci9ZonHlXCPyt4k8Fn3Rm7HxLlNVy9IWeIYzh9cH0ODRlXSH+RTLyrgRpSKnhxUv
	gy+n0YyDbaU/Sf9Mvvpaj9aUYlCD32lKCYno3FUL0L2Ox9/4seGgOMH2VC2co5lwfHQ==
X-Gm-Gg: ASbGnctZd1yQzqi8OBJxb20Q9wacb8hD6vI2YB2F66wcZJZzNcqSMmrZL9xgRQYW4IL
	tbprsFvjgNTU0sfsjEWCq3vwSyPxPx7T5hPgHprZID3Ffy1g7PTDSD1asQagvzVaV72/FV+5Clb
	sCOcbrMXaSWKA68eLITorEdRPJqa3tXOnpnxqOFOa84IqkSuMk5FDpe2SVJahCg2Ak84vepKgrt
	fnizpRPZXzcTFSdsPcbtjM2fzpLYX0yIkXUZPUP3IDk1nOWqIoSahweTNqhxOPLD8LAr8zsFFL/
	KuW6ksZHmNi1CNuJuuH6PrIde5sLlapO7jslKaCM7dLp/GjxbGNLG+AbUaMDXyPILnNwB7DFpVQ
	=
X-Received: by 2002:a17:902:ecc4:b0:223:44c5:4eb8 with SMTP id d9443c01a7336-228048f053dmr75861695ad.32.1743130113739;
        Thu, 27 Mar 2025 19:48:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbel5OU9VVPvSmq+mJRDr0WWkLTQQUnBLZZ9X+sMcZywyNWM+fF4WAX3Rb0bLQA+dxrcKd4w==
X-Received: by 2002:a17:902:ecc4:b0:223:44c5:4eb8 with SMTP id d9443c01a7336-228048f053dmr75861315ad.32.1743130113147;
        Thu, 27 Mar 2025 19:48:33 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291eeca203sm7317565ad.30.2025.03.27.19.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 19:48:32 -0700 (PDT)
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Date: Thu, 27 Mar 2025 19:47:33 -0700
Subject: [PATCH v3 11/11] Documentation: tee: Add Qualcomm TEE driver
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250327-qcom-tee-using-tee-ss-without-mem-obj-v3-11-7f457073282d@oss.qualcomm.com>
References: <20250327-qcom-tee-using-tee-ss-without-mem-obj-v3-0-7f457073282d@oss.qualcomm.com>
In-Reply-To: <20250327-qcom-tee-using-tee-ss-without-mem-obj-v3-0-7f457073282d@oss.qualcomm.com>
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
Cc: linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-doc@vger.kernel.org,
        Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
X-Mailer: b4 0.13.0
X-Authority-Analysis: v=2.4 cv=cs+bk04i c=1 sm=1 tr=0 ts=67e60e03 cx=c_pps a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=7CQSdrXTAAAA:8 a=4VYrYejmMApVX9KxlZkA:9 a=QEXdDO2ut3YA:10
 a=M0EVDjxxv-UA:10 a=1OuFwYUASf3TG4hYMiVC:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: BJMHRYNwY_eu5uhwjLJ34uA5FvR8GijT
X-Proofpoint-ORIG-GUID: BJMHRYNwY_eu5uhwjLJ34uA5FvR8GijT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-28_01,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503280017

Add documentation for the Qualcomm TEE driver.

Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
---
 Documentation/tee/index.rst |   1 +
 Documentation/tee/qtee.rst  | 150 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 151 insertions(+)

diff --git a/Documentation/tee/index.rst b/Documentation/tee/index.rst
index 4be6e69d7837..62afb7ee9b52 100644
--- a/Documentation/tee/index.rst
+++ b/Documentation/tee/index.rst
@@ -11,6 +11,7 @@ TEE Subsystem
    op-tee
    amd-tee
    ts-tee
+   qtee
 
 .. only::  subproject and html
 
diff --git a/Documentation/tee/qtee.rst b/Documentation/tee/qtee.rst
new file mode 100644
index 000000000000..8ae4da17c3a7
--- /dev/null
+++ b/Documentation/tee/qtee.rst
@@ -0,0 +1,150 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=============================================
+QTEE (Qualcomm Trusted Execution Environment)
+=============================================
+
+The QTEE driver handles communication with Qualcomm TEE [1].
+
+The lowest level of communication with QTEE builds on the ARM SMC Calling
+Convention (SMCCC) [2], which is the foundation for QTEE's Secure Channel
+Manager (SCM) [3] used internally by the driver [4].
+
+In a QTEE-based system, services are represented as objects with a series of
+operations that can be called to produce results, including other objects.
+
+When an object is hosted within QTEE, executing its operations is referred
+to as direct invocation. QTEE can invoke objects hosted in the kernel or
+userspace using a method known as callback requests.
+
+The SCM provides two functions for direct invocation and callback request:
+
+- QCOM_SCM_SMCINVOKE_INVOKE for direct invocation. It can return either
+  a result or a callback request.
+- QCOM_SCM_SMCINVOKE_CB_RSP submits a response for a previous callback request.
+
+The QTEE Transport Message [5] is stacked on top of the SCM driver functions.
+
+A message consists of two buffers shared with QTEE: inbound and outbound
+buffers. The inbound buffer is used for direct invocation, and the outbound
+buffer is used to make callback requests. This picture shows the contents of
+a QTEE transport message::
+
+                                      +---------------------+
+                                      |                     v
+    +-----------------+-------+-------+------+--------------------------+
+    | qcomtee_msg_    |object | buffer       |                          |
+    |  object_invoke  |  id   | offset, size |                          | (inbound buffer)
+    +-----------------+-------+--------------+--------------------------+
+    <---- header -----><---- arguments ------><- in/out buffer payload ->
+
+                                      +-----------+
+                                      |           v
+    +-----------------+-------+-------+------+----------------------+
+    | qcomtee_msg_    |object | buffer       |                      |
+    |  callback       |  id   | offset, size |                      | (outbound buffer)
+    +-----------------+-------+--------------+----------------------+
+
+Each buffer is started with a header and array of arguments.
+
+QTEE Transport Message supports four types of arguments:
+
+- Input Object (IO) is an object parameter to the current invocation
+  or callback request.
+- Output Object (OO) is an object parameter from the current invocation
+  or callback request.
+- Input Buffer (IB) is (offset, size) pair to the inbound or outbound region
+  to store parameter to the current invocation or callback request.
+- Output Buffer (OB) is (offset, size) pair to the inbound or outbound region
+  to store parameter from the current invocation or callback request.
+
+The QTEE driver provides the qcomtee_object, which represents an object within
+both QTEE and the kernel. To access any service in QTEE, a client needs to
+invoke an instance of this object. Any structure intended to represent a service
+for export to QTEE should include an instance of qcomtee_object::
+
+	struct driver_service {
+		struct qcomtee_object object;
+		...
+	};
+
+	#define to_driver_service_object(o) container_of((o), struct driver_service, object)
+
+	static int driver_service_dispatch(struct qcomtee_object *object, u32 op,
+					   struct qcomtee_arg *args)
+	{
+		struct driver_service *so = to_driver_service_object(object);
+
+		switch(op) {
+		case OBJECT_OP1:
+			...
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
+
+	static void driver_service_object_release(struct si_object *object)
+	{
+		struct driver_service *so = to_driver_service_object(object);
+		kfree(so);
+	}
+
+	struct si_object_operations driver_service_ops = {
+		.release = driver_service_object_release;
+		.dispatch = driver_service_dispatch;
+	};
+
+	void service_init(void)
+	{
+		struct driver_service *so = kzalloc(sizeof(*so), GFP_KERNEL);
+
+		/* Initialize so->object as a callback object. */
+		qcomtee_object_user_init(&so->object, QCOMTEE_OBJECT_TYPE_CB_OBJECT,
+					 &driver_service_ops, "driver_service_object");
+
+		/* Invoke a QTEE object and pass/register 'so->object' with QTEE. */
+		...
+	}
+	module_init(service_init);
+
+The QTEE driver utilizes qcomtee_object to encapsulate userspace objects. When
+a callback request is made, it translates into calling the dispatch operation.
+For userspace objects, this is converted into requests accessible to callback
+servers and available through generic TEE API IOCTLs.
+
+Picture of the relationship between the different components in the QTEE
+architecture::
+
+         User space               Kernel                     Secure world
+         ~~~~~~~~~~               ~~~~~~                     ~~~~~~~~~~~~
+   +--------+   +----------+                                +--------------+
+   | Client |   |callback  |                                | Trusted      |
+   +--------+   |server    |                                | Application  |
+      /\        +----------+                                +--------------+
+      ||  +----------+ /\                                          /\
+      ||  |callback  | ||                                          ||
+      ||  |server    | ||                                          \/
+      ||  +----------+ ||                                   +--------------+
+      \/       /\      ||                                   | TEE Internal |
+   +-------+   ||      ||                                   | API          |
+   | TEE   |   ||      ||   +--------+--------+             +--------------+
+   | Client|   ||      ||   | TEE    | QTEE   |             | QTEE         |
+   | API   |   \/      \/   | subsys | driver |             | Trusted OS   |
+   +-------+----------------+----+-------+----+-------------+--------------+
+   |      Generic TEE API        |       |   QTEE MSG                      |
+   |      IOCTL (TEE_IOC_*)      |       |   SMCCC (QCOM_SCM_SMCINVOKE_*)  |
+   +-----------------------------+       +---------------------------------+
+
+References
+==========
+
+[1] https://docs.qualcomm.com/bundle/publicresource/topics/80-70015-11/qualcomm-trusted-execution-environment.html
+
+[2] http://infocenter.arm.com/help/topic/com.arm.doc.den0028a/index.html
+
+[3] drivers/firmware/qcom/qcom_scm.c
+
+[4] drivers/tee/qcomtee/qcom_scm.c
+
+[5] drivers/tee/qcomtee/qcomtee_msg.h

-- 
2.34.1

