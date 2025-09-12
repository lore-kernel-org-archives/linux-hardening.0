Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8E9287263
	for <linux-hardening@vger.kernel.org>; Fri, 12 Sep 2025 04:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757650089; cv=none; b=d8M1hoJ2uynQr+sPHaUhfqxyTVZRpZ2bWD51rPteXayXRiZBD0Qng2ENG42wk+kBKbczOgmM2BF0+KecSejK9zz3XqcvTOPkh+7McuzHfCEKxzA8eFtTVJ37Kb8qk+jnwSvb+33sQRgsh/kVC9TPiWxxuwHl/w8zyw9XoDYPkf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757650089; c=relaxed/simple;
	bh=RN0nKuxToKAQ9VOhyNYte58FvHuKeDhMEOShy3rUoJE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s0c2KCzq+xyPRkBD6ve6q6N9bbvIbYyc0VsjZk6uQTL9rpVIIzsNJldo6n1ly28YcSVS9asjCuXs32ug2Uqi47nHGrXrDH6cBX6QOaFVVfnrLzBs9e4i5AfbOTP+XTTIKmSPVQGRfyxmLb4kUL3ACYYQyI+yMQiWaeu09piri5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=maeNwf1F; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="maeNwf1F"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BIIM96002479
	for <linux-hardening@vger.kernel.org>; Fri, 12 Sep 2025 04:08:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OdVTKF925ssMm3cQuiq+O1uNYUiJEhXOdcH2WTZnulA=; b=maeNwf1F+KqV/B09
	GtrNuOj9VsKp8/indOeA/tp7PIqvqOgB0XvIZkZuKnJuhuNhhlGT5xrlUKumPPQl
	61EhqbLE+O1bLU9K5pnTBp6DbhJDAED/bC60gnvEziBinzmbIwRKKI5LU5XarMsK
	TUe7d4dFy3/E8mpnP2AalvLD6ydWhv8Us+JIynxCqLvio5Q2uDhWUpDA1bU1ClJZ
	28oAOHl+c+ZVszJ1NyyO7VGIyzBJ9en7iGiKecFwV+GucH90LBa9Q3KpVIgEM+xt
	2NYl8E8evrO2QsEN3BYZfSUHfBlghVFHIcJUKPHpRtq8SAind5kJTqIvteNzd4NN
	/KKN8g==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490bwsjab7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Fri, 12 Sep 2025 04:08:06 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-32bdfd536aeso1319801a91.0
        for <linux-hardening@vger.kernel.org>; Thu, 11 Sep 2025 21:08:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757650086; x=1758254886;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OdVTKF925ssMm3cQuiq+O1uNYUiJEhXOdcH2WTZnulA=;
        b=HrVslUXXSM+OSUKW51+RyCj4T4uq73o1RBRChF191hIWNgoOcL1vKk0rDzaj7By8Kp
         Wb//XsR/QwKAXIfBFcFfXFEe4letjVwJ6/hMx5OHXUaFliRhhfc0umfizWQwpnV7seYP
         HcfqAPN2IJtXLSpxiz9Phf4dK4miPqB6s/mK4vMhd3H6gKmvaK5viHr9X4bvN7nCm3DN
         IaE2UxdXy9R0apPocLZoImbSM3v7Tg+MgqqCIZGdaoLJrxXbQYogW17W8YOGqf6BtrqV
         iis/ic+PhglkkhOZjk2Y6yo7OitJF4amzeJCanOFL6h1SN90Jp5pgaalRL9oX7fORUhE
         ARNA==
X-Forwarded-Encrypted: i=1; AJvYcCVAybBrJlpxYuUP1Csdi2gnlVzifVZ3MxBcwyzB/eulWSRkX9PK5bsD24IDVwkymz4+GdT1rubXwV4N7KpyDg4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzry7SoRx0ziKgtQOYes66iMyU8E1w9sZTYF6txC3h+RenA3wAL
	xfHJu666UkkoqCgFsWfRviQOhNdd/fk64go7rjuFZaMul12BfJTFSdD9MCMgcFrRMf7SU0TYOmb
	cO+oYoOhDiZkWxjvpVz03LeyKBr/ZUrDbB3VCKmlWyzqvzxwZk3DZV9ooPGtofxAVWZNYfw==
X-Gm-Gg: ASbGncvfZngm1ORto8V8lwIA4M9qBCwmZaMU/eo4wiMqrrOn7yNa2PSr7u8vK6z+J3h
	DF5WOBXYa9FGtJvsv8WpARNmFLHLbhYFY7UmUM6hmjeHhMlZpuC7ahI820bpNsnpgwe9WRnOGpl
	QdwqnR+88OhI/kEa+RUwPi+OkqBeiUyDVYSnfBcVZtamHOtOUc+cht310vcWRqo4lAVi44bXHit
	uWbASR2bPGfnCq6iWFwn14q8KdloDQeYpugQPSLAaDyAju6av08ssi/cjoKpAmm91K2sKoSdNP2
	L31lBAq7pOw1eJL2ynA5CKOInNkfFfFfPL0wvCql2+mxbt9oe2GO8nv3oDb0SmEfPYY2jg+MM0h
	huxShapBmR/sirjivjDtuLMA=
X-Received: by 2002:a17:90b:35c3:b0:325:25fb:9128 with SMTP id 98e67ed59e1d1-32de4c33d52mr1818612a91.9.1757650085505;
        Thu, 11 Sep 2025 21:08:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHX1RaQl33ilIfwxao3aJgpnfFU7FLqmjTzLfuny6Mj/xGDe+7OnVCAMTCzx6nAXfuI73Atcg==
X-Received: by 2002:a17:90b:35c3:b0:325:25fb:9128 with SMTP id 98e67ed59e1d1-32de4c33d52mr1818571a91.9.1757650085067;
        Thu, 11 Sep 2025 21:08:05 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54ad5e168fsm690960a12.13.2025.09.11.21.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 21:08:04 -0700 (PDT)
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Date: Thu, 11 Sep 2025 21:07:50 -0700
Subject: [PATCH v12 11/11] Documentation: tee: Add Qualcomm TEE driver
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-qcom-tee-using-tee-ss-without-mem-obj-v12-11-17f07a942b8d@oss.qualcomm.com>
References: <20250911-qcom-tee-using-tee-ss-without-mem-obj-v12-0-17f07a942b8d@oss.qualcomm.com>
In-Reply-To: <20250911-qcom-tee-using-tee-ss-without-mem-obj-v12-0-17f07a942b8d@oss.qualcomm.com>
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
        Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailer: b4 0.13.0
X-Proofpoint-ORIG-GUID: mOxKkzC19SCI6ZvJsByjbxcGON4mVSZ3
X-Proofpoint-GUID: mOxKkzC19SCI6ZvJsByjbxcGON4mVSZ3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAxOCBTYWx0ZWRfX3Ps5vcMFF1co
 oM0dJ9g7YwPlEvrGJFiH7hwDJTcNnJZQD0MWb/PwLCvcVJZVZqCk/nfK5I6R9QOlPCz6MBSFNeZ
 u1W8qB2ozMopNYyBLUfRouHu0lF+JcRRmOTGta716ocn/9+Db5BeDqkwN5CEpezZJXboxGbH4qI
 U5fKxJxhrNXqaEVgpDN9/16CRd26qrU5ONnOm4u2CDOD16jg2FnNWYFtS+uaguTjjLxM6DzVYGE
 xNRvmigCMMlDAKlLKS7FrLUtNRb0kCIGbgrGJqJKzxai/h7xcn5BVKt05EmdQBKtHvLm8aEFJ6d
 2zJ/E5yGHX9jd38RtKZ1oCavbBwgPfruK9+zb5TUf0Bbk0SI5FwkJGT8++K5eBFd/DzyTT5QCay
 DomLhKhB
X-Authority-Analysis: v=2.4 cv=G4kcE8k5 c=1 sm=1 tr=0 ts=68c39ca6 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=7CQSdrXTAAAA:8
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=vCTlBN6rBY5pDr9NrAkA:9 a=QEXdDO2ut3YA:10
 a=M0EVDjxxv-UA:10 a=uKXjsCUrEbL0IQVhDsJ9:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_01,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060018

Add documentation for the Qualcomm TEE driver.

Acked-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
---
 Documentation/tee/index.rst |  1 +
 Documentation/tee/qtee.rst  | 96 +++++++++++++++++++++++++++++++++++++++++++++
 MAINTAINERS                 |  1 +
 3 files changed, 98 insertions(+)

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
index 000000000000..2fa2c1bf6384
--- /dev/null
+++ b/Documentation/tee/qtee.rst
@@ -0,0 +1,96 @@
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
+Manager (SCM) [3] used internally by the driver.
+
+In a QTEE-based system, services are represented as objects with a series of
+operations that can be called to produce results, including other objects.
+
+When an object is hosted within QTEE, executing its operations is referred
+to as "direct invocation". QTEE can also invoke objects hosted in the non-secure
+world using a method known as "callback request".
+
+The SCM provides two functions to support direct invocation and callback requests:
+
+- QCOM_SCM_SMCINVOKE_INVOKE: Used for direct invocation. It can return either
+  a result or initiate a callback request.
+- QCOM_SCM_SMCINVOKE_CB_RSP: Used to submit a response to a callback request
+  triggered by a previous direct invocation.
+
+The QTEE Transport Message [4] is stacked on top of the SCM driver functions.
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
+      ||       /\      ||                                   | TEE Internal |
+      ||       ||      ||                                   | API          |
+      \/       \/      \/   +--------+--------+             +--------------+
+   +---------------------+  | TEE    | QTEE   |             | QTEE         |
+   |   libqcomtee [5]    |  | subsys | driver |             | Trusted OS   |
+   +-------+-------------+--+----+-------+----+-------------+--------------+
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
+[4] drivers/tee/qcomtee/qcomtee_msg.h
+
+[5] https://github.com/quic/quic-teec
diff --git a/MAINTAINERS b/MAINTAINERS
index bde449308736..589f8ea62bcf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20860,6 +20860,7 @@ QUALCOMM TEE (QCOMTEE) DRIVER
 M:	Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
 L:	linux-arm-msm@vger.kernel.org
 S:	Maintained
+F:	Documentation/tee/qtee.rst
 F:	drivers/tee/qcomtee/
 
 QUALCOMM TRUST ZONE MEMORY ALLOCATOR

-- 
2.34.1

