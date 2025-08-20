Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B77C2EB5B8
	for <linux-hardening@vger.kernel.org>; Wed, 20 Aug 2025 23:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755733164; cv=none; b=u8n8y2E0rv0UpNxc94QGIIodG9A4PaNiraRv2QT49wP8G6uuSpC0EFQ9Wswu3vFpU0l8GB5dxMnAh7vogm5B/zoyxTTGCwAN5P5O+KY+ZS0Csfyijw1Msf/yUHRg3O9jJQ9YlsZVBFKF5AT0oEzOoXysjPy7uSv/AU/o/PUqWAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755733164; c=relaxed/simple;
	bh=qk0syZPjN26GV0OvM5j1GqyRmytI/+DM+x7GbfYpGks=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RLdvvHXstV3KTPpmVRYc7iF67g0anuggJ0TXJbwStiFYkfS+ysnhV2lnm6J6uUlgPZg/qtp/NvWXKq7xqiZ/unvag6ZPW6jUUk9mQD330b2Gz2fmc7KzzGS0JX+aeaXZprn9CKayDX/wK30E4Yuvur4/VbW/yWXBfPa44dMaG9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nZHEP+4W; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nZHEP+4W"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57KJ0rSF024114
	for <linux-hardening@vger.kernel.org>; Wed, 20 Aug 2025 23:39:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3IT/Y57qPq4F4AgT5FsnG7qdoV203DyOX4ZKaC3Y1gA=; b=nZHEP+4WuQ1n9/To
	DnperLhDcVQg3zsU11f70y1SHGVIATCVcIhOCyRpo7FcKUH1ToXqbZx/8a7KahT+
	5/9xMkbcVTlpxkcoCI9lIO/+YCOeBSOxqIEpRdeE6ggo7RzBGErBI0holhwSDHfD
	4w5rnBz0240SZUygi1dwAtibNmWblnd6jB59p3cMvS5gdnw+CsvspD4EFdPRIpEX
	EevwSTSPvyeEr9937tKocXLJJbSDhhpwr3aW4eDOZBgM9ov2hDd4I4ojs7UB2l8+
	NkzoRtTXPToekumMtfJcBciHimg1YrbShp4BbadCO0ft4xPl6K0+XXrIhQfwZa9s
	UZwj+w==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n5293ctt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Wed, 20 Aug 2025 23:39:21 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b47174b2582so598374a12.2
        for <linux-hardening@vger.kernel.org>; Wed, 20 Aug 2025 16:39:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755733160; x=1756337960;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3IT/Y57qPq4F4AgT5FsnG7qdoV203DyOX4ZKaC3Y1gA=;
        b=E2ko2mcmgD7TuntLK1C9RjVik/WpOoPW8D0UYUsVM9eZ5jq9+Mc/MdkrJQijKKjZ1b
         /WTqnIb+Cq5fGz261go9BJj7j4XjSXvXljVDfqjn3j9vxvmX0y4U11pzkeRA1+S9KPa1
         w3Lu46db8kIVwVXf3JfMFvkD/MF5z9lKbxakdrVsZ1tChJD8Wr9rmepiVZHQ1+HA9HES
         //tFXTNevJvu6XZw5UARqtpPY5oWeyYNWfq5PbDXRzvl3GuKce99uDPY1jkDbdkuW2eD
         OqpRqwfD31k3zdSrxe+cvEdCLCDXKhH9BPVSWlPZDP6IvYWkXoZYVI+nCAMjoRbN+URH
         /Exw==
X-Forwarded-Encrypted: i=1; AJvYcCWI2fR6tQLBBf8+Y/1WlPNGODSTSzvN93a3NUMO08ogzuQek07uwfCMjyJaS/UzXPs/nukkGmUVXCMx2cuq28A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGaMnMlyMYzWQkG+Ne3Oj+Z3omUYVCJjWrI/D02y6wmnvakgRU
	nLGAHnqzXe8VWD14MZoHSH7yHA5kBwefEWsmCqu51moHPKzKZCwOMPbhv3AGUTjzOyoTuFwzIw4
	emgmYZSqfbIxYC42FnArSMCDHeAkiu5i6URUA2bg0BFAW7blnYAjRcwsFUV6UGACtnEX+5Q==
X-Gm-Gg: ASbGnct9VOuwC5kJ9E43QsfARkT+AFTW7o7nwwWbzjnQuwPXgUkje3y/XctR9ZWLXrQ
	SPeMf/iXQEE4qZ2CyCRpjnXcrf/RMF5N5tpb1PWYO7nMInxKkuI1HegZ8IjwLSmJxfXeB+YTmHp
	LcMwHbAhpO3rFOHNP1v13447oEUTVDGzgHoB1yPY5r7vDFjvwtollEsis4VCHmFWpgQK9wHuAMi
	B2vr6/UcjbM2+zAxzw+fEnXOnqNuJB//b0+/bo/+2VO749DBizQ+bvTUFsz06r+mkj2kOln2S5P
	6SKyDk7jjdKAZeTX0x2ZEJonfVlWKo6iMP5Babgq7R9dciRWsDCR/4GME7SWJv6XXk+hMp/QmHu
	RGWPWLhmqiAupF25o1ecHG9U=
X-Received: by 2002:a05:6a20:5483:b0:240:1bdb:bed2 with SMTP id adf61e73a8af0-24330a03786mr380919637.32.1755733160286;
        Wed, 20 Aug 2025 16:39:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFw1pLKNzTWTbzCfpH9IHrJ+XiNqm6aCe9WthFIxWIMqQS6/C2skgzNs1xr86S69NG7mxyZlA==
X-Received: by 2002:a05:6a20:5483:b0:240:1bdb:bed2 with SMTP id adf61e73a8af0-24330a03786mr380900637.32.1755733159836;
        Wed, 20 Aug 2025 16:39:19 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4763fbc711sm3233028a12.2.2025.08.20.16.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 16:39:19 -0700 (PDT)
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Date: Wed, 20 Aug 2025 16:38:58 -0700
Subject: [PATCH v8 11/11] Documentation: tee: Add Qualcomm TEE driver
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-qcom-tee-using-tee-ss-without-mem-obj-v8-11-7066680f138a@oss.qualcomm.com>
References: <20250820-qcom-tee-using-tee-ss-without-mem-obj-v8-0-7066680f138a@oss.qualcomm.com>
In-Reply-To: <20250820-qcom-tee-using-tee-ss-without-mem-obj-v8-0-7066680f138a@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=ZJKOWX7b c=1 sm=1 tr=0 ts=68a65ca9 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=7CQSdrXTAAAA:8
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=vCTlBN6rBY5pDr9NrAkA:9 a=QEXdDO2ut3YA:10
 a=M0EVDjxxv-UA:10 a=3WC7DwWrALyhR5TkjVHa:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-ORIG-GUID: xJdMf4UbnkzW0reB3aVv3tfeC4Ut9f3N
X-Proofpoint-GUID: xJdMf4UbnkzW0reB3aVv3tfeC4Ut9f3N
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfXxas+QeXK0dPj
 bRAlAHhsbdJsHsJHApzHnT8dOHLQul2iyceoH4/T25/rSSHCWmlWKSeCYG8CUHCTXtkIzI9Mgvb
 h7io4tUWGwn/GKnM4X/UuIzeDiwG4lBiKMzHqXPObDsasR7JLv0Gz8QBs3EtGt1LUqmuRVALRFQ
 ztjxTuNE8YjSoXFWSbbV+Of1oThb+lgWrvkTRJLtzfYcsVMybMpYoCOXUOIMEAnYrKerincE06v
 q6u9awOHG9jDUpZNN6N1/7ewii3lna2TfZg+pEu+MB9PJ0SFFfBi02mNAdMMwIqEudetb+1UIYK
 40V7OexF/Ftbc9wXUXJ/832wDdj3leXLcwogi28W/fHC/xqbbxH77rpNYRUTANgmeMqYoyxYXpy
 4rwlYxr3Q6rZ7Ym6kyZ7cDeg+z/1lw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_06,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

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
index 7bed4117d655..fc5d403b75f4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20959,6 +20959,7 @@ QUALCOMM TEE (QCOMTEE) DRIVER
 M:	Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
 L:	linux-arm-msm@vger.kernel.org
 S:	Maintained
+F:	Documentation/tee/qtee.rst
 F:	drivers/tee/qcomtee/
 
 QUALCOMM TRUST ZONE MEMORY ALLOCATOR

-- 
2.34.1

