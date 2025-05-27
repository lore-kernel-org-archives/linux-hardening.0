Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83230213E94
	for <linux-hardening@vger.kernel.org>; Tue, 27 May 2025 06:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748329060; cv=none; b=oYsvv5Etodb556bhSwRUKrfDTP+AtWqeFSRc5LVqWjMdxYIjqAvJazMoZU+ud75woqNpifX4TaMqAdw7+mksX5nVwndp0xgd+2F2ffqOS5eySm/e3IZWdp8jzFHCZfXPZZdYGqn4VwunJ08nCAvRNbrK5nSirx4drxHaqOcROkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748329060; c=relaxed/simple;
	bh=alYcFVrilYxQEpqmSFlskvHe5qmrItaRn3frkZSRWk0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DTQM90+DBAb3QBLEsNIP7hUvo2yj98qNipG/q/6vFJmFzY4mv6xLRzphMuWfjTwVUb6P9sl5VuoGG4HfmW8iHuzlOkIdl6XrWAPlaeWyQKTYnHMBlydDKuPZga9UVvfAmOP1OFf++OhQ5kx9LWXMKNjWiaxjc++DjNDSZ8F2utY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oGUYS1ma; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oGUYS1ma"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54R0TNNi014923
	for <linux-hardening@vger.kernel.org>; Tue, 27 May 2025 06:57:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LDW2lLJjVVFwgwPCZKo49aI6NM0IvCEjQ6HwcjeAopg=; b=oGUYS1maWn4Fkpeg
	wt1ereETu9Y2GodTAKm3Wjmi48R47J54W88sbKhnxcDqnRHv3ljn5lydw/A2v2CY
	/UzW3DWFHQOgjdjcpZFzWrDxaCdAhGej9lEaIS1nmWvO5SI55NFEUvZ+VQXPpJHW
	0lklA4f22/fQuVcHxJlvQ4CZDptISozn1nGQrlQMsJ3BpYoVf2Yqb5jUw2UpNOcn
	hY5v4zvsDrySvBTrr4WtPtctLDL4ayLRWO812IvQl3idbuQch4vQycahbvUgbWpO
	5wAFRW1iwBFM+e7U3SqJbChOZ0Z8TPaMKZshuypvZxHNqa1JlPy3ffDlhoSl07/f
	cUnz+A==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46u66we4fr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Tue, 27 May 2025 06:57:37 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-742c5f7a70bso4259736b3a.2
        for <linux-hardening@vger.kernel.org>; Mon, 26 May 2025 23:57:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748329056; x=1748933856;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LDW2lLJjVVFwgwPCZKo49aI6NM0IvCEjQ6HwcjeAopg=;
        b=UHD6fXywu3KNmjyeZzBXSyOp9B1OoH0FY+yTnoXhXMJo0/0JLqG37JZFCI32p1yCO6
         wWADaBW5Y/NotRb/oM2NyuPKcnTEMOaQd2gBuhOKcnikeTeazUoz6AXwMc2m9pC40S4j
         x8umFMhRTw0P7PDdhZtsmVsJ9BEWpYQsPhpKX35TZlv/6Zws39uH0S2CgB18hyq/gnXf
         L/cycqJ6AAj5W0K+ibJTy9ClHehX0sunpZDuGgFQTpzFTtlDDltGqWkG1rsrF7aFNsGl
         lDGW9WakOJ4dnV5liA2cpF0WBMqHlhvEOONokLVb9eAyE4CDl0JcP2GFgrVeqoLZyVYQ
         JDnA==
X-Forwarded-Encrypted: i=1; AJvYcCVOupsPoDOVdBG4HnJUrDBycZqUYLynOi2xIePObFVkIIdyVALmrMqrtlBKxoljHFCEsM73uSe+SmHlXJ/4L3w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqo5aFz6cHc+Yy8oCisbTkfttdNR/2jTKN1uV4y1XgNQIqE8/b
	uJwPdnA7jAipMXg9jUmUdNkMhxRp6KbqB0QeWnQaoCJOLmdBFs88vvq2NoccEsN/tCSoZPLKMBR
	KplTwEiwFOymMCVMtYHvrEFkaA1YNFsjsMe139P5AuR7nw/u80ohyKGNe0aUQUp8vEo2WwQ==
X-Gm-Gg: ASbGncuV+wzeLPatMVyQYCji4yrXjZeGZYU0xj+fzAU944dueF9cHHFsQMG4lybBmiU
	p5sQ6zVRE8yBPGkQdSrHsQhw7zCtrNtZlosbNh0dhsg94qFFkSqQdWx4AUSPgSII92hkJ8hEnvd
	IV6dwE893vTvyYw+82c/AIlmC9oHR0WAifrVC3caFeT/6Qpyw0Vfe2lWaS38T9Tm3SZvWWKIycR
	IoVNLSwKfmFDcqt7OpjTAYJTXDWGLfz00XxhXHBr1Yp+RjE3KwWenJoD1KO0+b0BJg4GQZtJt3I
	tSzQESgEGLIvBQFG+s589vyyKs0psHfl+ZB+UqO3O1H0eqRgPJDT2dDOKMJdU2wUKnNV7XA=
X-Received: by 2002:a05:6a00:2388:b0:740:91eb:c66 with SMTP id d2e1a72fcca58-745fde95d69mr18679025b3a.3.1748329056146;
        Mon, 26 May 2025 23:57:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHatwnSlnB4ysD1+0cl+0KDFq1qTpPuz2/PIHrgjsZTiQ1dLavAZ2MsgRFbjk4IiymG+qhS2g==
X-Received: by 2002:a05:6a00:2388:b0:740:91eb:c66 with SMTP id d2e1a72fcca58-745fde95d69mr18678947b3a.3.1748329055325;
        Mon, 26 May 2025 23:57:35 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a970954asm18037286b3a.46.2025.05.26.23.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 23:57:34 -0700 (PDT)
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Date: Mon, 26 May 2025 23:56:57 -0700
Subject: [PATCH v5 12/12] Documentation: tee: Add Qualcomm TEE driver
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250526-qcom-tee-using-tee-ss-without-mem-obj-v5-12-024e3221b0b9@oss.qualcomm.com>
References: <20250526-qcom-tee-using-tee-ss-without-mem-obj-v5-0-024e3221b0b9@oss.qualcomm.com>
In-Reply-To: <20250526-qcom-tee-using-tee-ss-without-mem-obj-v5-0-024e3221b0b9@oss.qualcomm.com>
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
        Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
X-Mailer: b4 0.13.0
X-Authority-Analysis: v=2.4 cv=aYJhnQot c=1 sm=1 tr=0 ts=68356261 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=7CQSdrXTAAAA:8
 a=VwQbUJbxAAAA:8 a=4VYrYejmMApVX9KxlZkA:9 a=QEXdDO2ut3YA:10 a=M0EVDjxxv-UA:10
 a=OpyuDcXvxspvyRM73sMx:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-ORIG-GUID: KfKyNl1XS3FsvfqUavrP_e42L77eEo9l
X-Proofpoint-GUID: KfKyNl1XS3FsvfqUavrP_e42L77eEo9l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI3MDA1MyBTYWx0ZWRfX7G2u1P7Ldqp5
 DwPQe0wYLz1tae1FtY0Zu38BVJ6dW04wpDC1Lb8gYllzeawkfueWLwglhXPrhDU9pcPfWAyLm0S
 6omU/RgiVFE69zrb5ru5HW9CXdcqEY3mKEjdtB7WlvgJlcSiHqsW3nH0uRdomuDWuyIgixb/326
 Sum6FFokgeQvC9Yu+lXvh2ZX5nItC+FM3nDqrJgysW/UoMmUWkP8duNGwYysOnhbnshSPm0liJ5
 szwTdqqJqsoq4sxGxhlDTgOmk5poLPMe0PJjt7YIrnbRhYq+r0fGO7lCXEIKH1ajKVG7aOPEFRO
 OVxQtvAvVOtzDbv93bS6qvcsvZccetG9txemwzRDcM69JPKs1lHMkdmlifnQ+ymhaPT9BYs86wt
 5nbDhtldNgNB+UcXSTJYfBcOdX4+WuVrsjC95gLZD/NHbPKvuiGBcq6P20I9J6w3OnB7HLhe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_03,2025-05-26_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 impostorscore=0 adultscore=0
 mlxlogscore=999 lowpriorityscore=0 malwarescore=0 mlxscore=0 spamscore=0
 clxscore=1015 bulkscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505160000 definitions=main-2505270053

Add documentation for the Qualcomm TEE driver.

Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
---
 Documentation/tee/index.rst |   1 +
 Documentation/tee/qtee.rst  | 150 ++++++++++++++++++++++++++++++++++++++++++++
 MAINTAINERS                 |   1 +
 3 files changed, 152 insertions(+)

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
diff --git a/MAINTAINERS b/MAINTAINERS
index 99fe1ae22ae0..42823d33cc03 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20515,6 +20515,7 @@ QUALCOMM TEE (QCOMTEE) DRIVER
 M:	Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
 L:	linux-arm-msm@vger.kernel.org
 S:	Maintained
+F:	Documentation/tee/qtee.rst
 F:	drivers/tee/qcomtee/
 F:	include/linux/firmware/qcom/qcom_tee.h
 

-- 
2.34.1

