Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3702E11D6
	for <linux-hardening@vger.kernel.org>; Tue,  2 Sep 2025 04:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756788994; cv=none; b=ThJ/ldl08l3OylweckATbXpSKt7KPppoHgz1cO6JTt8oxrdBEfnH27PMvz9Qx/S6b1mGvXkU/stfzA6+M+uM408+LyE3rGKEWCb+2RJYTH9YV+dZKhhEGpwMP+T/l0W2JIIqpXMEFGmytX8g7cA9jOLY4FOT8u600VpZzSJ4cQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756788994; c=relaxed/simple;
	bh=696U7/FWwaaFIGlzeZRWykn9zjUkr8pce7ma6fekJEY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hlv1j5mjb4RGrruzDXJb9AgDA4SC8rWPo4SKfZl6iIGwvBPdu7AIE/3rCojLEu78WtcPdGBmaV05JwnJxonTi+H9+l7u9Yz/nz1DKY9C4Hj/ZCC0HMsM850HqfO5PE+UivrOvuSLtEBA5PlHZHVcH8BaIbMFpVJiUQNow52Hb1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Tx4vpK2W; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Tx4vpK2W"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822S9eI030159
	for <linux-hardening@vger.kernel.org>; Tue, 2 Sep 2025 04:56:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4C5VhC/4pFCnYsmQJ5EmNbV8HXu0TRSksgnPURzlR3I=; b=Tx4vpK2WBWhiCtNY
	sm8/FoCB0SlXn37FORfYCgOjeQemeJ+LUOOETXQnEpU3iT1gg48+xYQYmiqqEDjH
	YlLvUrEakatZJT2NVCkbY8cC1x0OY4F28Xd89XznVUJb6yGUmoebgKRG9OMfZASS
	cVB+1BG8wKyNAk8rId4bZlpUCSiZ0jW0y2HCxJgJ9tJ1cQt1nh5nlA/6noek+//f
	3lr9VfvgN2Ogih1uKI0Y40B0KWdbBNOm6OTbb+JmIJnk+7IdDbq4f7ICQkKJiXV4
	7hOBQeX0qItaRIg7VEu2hEnVwuUVNMUcXIz1lrWg3kACSeXjqt3ZCYTboFHAW90v
	G5CdVA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48w8wy2b9q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Tue, 02 Sep 2025 04:56:29 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-248981c02cfso54470365ad.1
        for <linux-hardening@vger.kernel.org>; Mon, 01 Sep 2025 21:56:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756788989; x=1757393789;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4C5VhC/4pFCnYsmQJ5EmNbV8HXu0TRSksgnPURzlR3I=;
        b=XgT1Vhs01O1+OK6kqOY13FyIh9erbnid0nQLxWKZcGl9ytzL0xjQah6dcTD3dGds8Y
         smbFFKcB1i7oLhpBj1PEaUFOI4Om+BeIZGqf9Yz1LgqNVKCkx3fM9aYdwT4DkyKBx9+c
         xVviJYCIFaf+doNgoLqPmukBooL0F5NWK2FeG+RNKGOozQ3KAQGY9SBpW1rNEkCQPtXB
         mPxPi7CVUuq37JTPxQjGPtcASqL/MijH4NMU2QnH65Z4Rw+g/83W7+JeVqMVFtZuDaJE
         S/t1TH+swuP9NGqpURHCWC0pQkVjCCm12OHULrZ+70yTaJqcXXX6eZrebfhFNah17s60
         2sRA==
X-Forwarded-Encrypted: i=1; AJvYcCXP/q2EJ5UfvAfYP30zMBwKNo3IRjzQFrNmBjKqootCTU6qKH2INp8r7x530GXEDpkOVwI4hXp18JyWi+AsW1A=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx41DSKXFG76WWtVDY1DDBFhlSiF7hsjeuZchTsodKAtYA52Sp
	rDtFg1Bb70XtcSv1cs+IJBgwIlEyuKsMfLhNnKO9K1Fo/ydW+sRmhuaz1P5//cbsU9g81a3USsq
	03SneZKLBE8Ko76QCzayNfj2w+4TzorwImTIuU1WVXFzeOWjrWXA7qiYPEmdPvTtzAHP6ag==
X-Gm-Gg: ASbGncvKFAs6AQzOnvOi6XKXmp+/unbFZod7H+AoI5HIBbVL4PGkG8dn5QPNlaqtuhA
	JlXyBJoUzpJeVedDSM/wWRpfIz8mckIEhkPv9PypeQ+rP2LesNo4I2GoB+eL4/RuHt/LZkZNeJp
	CSB5VpfcVx87bVpYH9VT48z6etCVgskuCFvYucqd8gRLjjxl6mjDjNN0oEV2hQBpc+P/7YdI9HJ
	pyFMYpTh53vMFEvDZjfZtouus9dTYU9PumiJm5C1lYw5S5ZQMxYeMryEkCmplStbKFQTJIBwxB9
	ZEq/mG9cptiJ5uZTYCoA4jZueQi978XjsBUddWjnTYGfOzHfi3ZR8aAf4Iyu1KT6zsgox9mHvUs
	7cqvWTFBLe03VfkJe2tjhfEA=
X-Received: by 2002:a17:902:d502:b0:246:fdf7:2c71 with SMTP id d9443c01a7336-24944af12e2mr132951115ad.47.1756788988608;
        Mon, 01 Sep 2025 21:56:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7F0eEjJmAaiuShpIkxQfExITaVHfEaEVCThMdzzbDlLzUzKrz3dCFXLdIOBLWZwLgt+OxrA==
X-Received: by 2002:a17:902:d502:b0:246:fdf7:2c71 with SMTP id d9443c01a7336-24944af12e2mr132950855ad.47.1756788988089;
        Mon, 01 Sep 2025 21:56:28 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24b1f30a63asm1795345ad.66.2025.09.01.21.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 21:56:27 -0700 (PDT)
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Date: Mon, 01 Sep 2025 21:55:58 -0700
Subject: [PATCH v9 11/11] Documentation: tee: Add Qualcomm TEE driver
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250901-qcom-tee-using-tee-ss-without-mem-obj-v9-11-a2af23f132d5@oss.qualcomm.com>
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
        Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailer: b4 0.13.0
X-Authority-Analysis: v=2.4 cv=Ycq95xRf c=1 sm=1 tr=0 ts=68b678fd cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=7CQSdrXTAAAA:8
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=vCTlBN6rBY5pDr9NrAkA:9 a=QEXdDO2ut3YA:10
 a=M0EVDjxxv-UA:10 a=324X-CrmTo6CU4MGRt3R:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: ayNNTd1qgZbvwMhTWlOc_0LASLagHNfe
X-Proofpoint-ORIG-GUID: ayNNTd1qgZbvwMhTWlOc_0LASLagHNfe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAxMDEwMSBTYWx0ZWRfX9Twqq5uEAnb4
 Cckp7XmpzijVuCARlUnrwhrhW1EVQFGv2NcgLJ/tpW7dYPfNyz7wcIMupfMVF+vgxQF5z2PH3mW
 Zz1vD6F3SyCoIfkS95XsczaHkFGuLSb1JLsUMZGlc9IOVllgmpUOgr96JhvKzKKz3Z3a/ijGBFg
 E0YaFCUHZkEZWDiKTNzUCmthQ8c0LFMZjPNDXUFYn+456IjOj+JUHcxXhW7URqOBtBJ3pQLNXWG
 VCPRHR+SRtdi21/14s9BHJ+rUP0FzP82nvHmCKu0Hkx4z3Qaskz0EZKtYanXplqLsXqi4z2tmQM
 JFY0NlOHQzv2936//APRNR4HoSgRS6ygyem4WR0CRSD/0e9E3Fo4/VwovCzKiVIFeNBoPu+nF6+
 5wgAHN2b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509010101

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
index 5086db700aeb..bac9436f65c7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20984,6 +20984,7 @@ QUALCOMM TEE (QCOMTEE) DRIVER
 M:	Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
 L:	linux-arm-msm@vger.kernel.org
 S:	Maintained
+F:	Documentation/tee/qtee.rst
 F:	drivers/tee/qcomtee/
 
 QUALCOMM TRUST ZONE MEMORY ALLOCATOR

-- 
2.34.1

