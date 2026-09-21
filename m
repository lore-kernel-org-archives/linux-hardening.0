Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035744BB282
	for <linux-hardening@vger.kernel.org>; Mon, 21 Sep 2026 15:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790005011; cv=none; b=SoAo2H8nUHpui89yc+LKB1QHvwARE0Y0YVki9QxxK+q0PJ06VcJHpTO7cDZXcW7dyxWRVBNQkyQFnytEwPR2Q5e5mJBpLnNntC9T/IM05dvnqEzqRkga3m46B4Qsxa5MoyIgwCbIS4EbGLG/9E1qGI1E8yFKZnQgx0Ylwgs2YvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790005011; c=relaxed/simple;
	bh=4quN1Jn/p1akrl7Kb3jtp9Y7SGPyf8KZA49TUogsrIM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YzNAUWT+KaWl4G5n/LyhxzmNxhs1f7/nx/SBR87aTsXmQsieDcI/XcpShemdL+QmN6tN74WH6SIo4ACvNGTVFeQasP6Yx6erUiY77z+j87ihuFnyIF0sqGB10E9v7yoVO5Y1EKH6wRWUyrDpMIZ++uAiilkGi2q0AZ7UHGi9iA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kn099I9e; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RjDMjLc7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kn099I9e";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RjDMjLc7"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LFAIO7223162
	for <linux-hardening@vger.kernel.org>; Mon, 21 Sep 2026 15:36:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7z8K/+XlzaRtSr4F7nzQBwLm1rNrFUrCsH9SFZwQqR0=; b=kn099I9efGVyNZmI
	6gJhY+KGuyJAxzS+N/6ugJgVuFT1mxp4UnAEymfW2ZeSNYX4M6vYZ25JA/r0EOwq
	wtGrzP93tg/LaLuUMfu+HPlHtdDpjTgXrbe+iV7gM5ztTl8OAxaD6x2UxQmVjFEj
	ms6wFqVslZn0G7cmXSihF65P7qbwQR2TIWKeC41uXGNiWlBdU5k2g9waWtqV+NxI
	y0V/1GUUd0eE0cMNUJHW/hfTWpLGevNoBkVGkFzKQziRlPtpPNLgDc6sWCyLAJz1
	Dra/3pVEpFAQUMz6PQdLFXOlNEojPJZBRbzANXID2O7CYSvZUSKs8EJe7nVMbKzg
	vhIRLw==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gtq79be6m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Mon, 21 Sep 2026 15:36:48 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-98331b577e4so2436380241.1
        for <linux-hardening@vger.kernel.org>; Mon, 21 Sep 2026 08:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790005007; x=1790609807; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7z8K/+XlzaRtSr4F7nzQBwLm1rNrFUrCsH9SFZwQqR0=;
        b=RjDMjLc7A0IKNiaaDfR4aWxN1IV46w5ErRcJBmNMw6yjyuHHhDrbwG0FsE7MuTQxu3
         I8e++okRXWMqRWVtfxm4hy4P2TjngBNT/E8UHQk+it9PROaKkhwyp7sqp3dGVg+VRjae
         j6F65yPg9YMN3NgDWeczYVDY+954XiMCDSWPw2Y7erwBQoGJDmaw5e8fYqG4rtrKsnoL
         LFuI85wtRVE5auvYA2o5+1XhQEFYeGthyiG1hvMXodc1F1ytt6A10jG8MGF56ieH28cu
         OMZTvGdw+fb8nMUx6AAY57GEor+ijcd1OJ1xu5GfuJRj/ULvLV1/f0NM9pUXEvuPk0pc
         Tcig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790005007; x=1790609807;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7z8K/+XlzaRtSr4F7nzQBwLm1rNrFUrCsH9SFZwQqR0=;
        b=1L/T2KBN7cBXWrtf1zpigpg8PNWD2YkZoZO/lBRuY93P8LyoYcgeu5IWbeRIU+vNQR
         9f4yxePF9j68Uk1f/vH5Cw97dZxpY7OEMKIuRoq3sCZprgLv1THfqh/95oc9JqVENjgD
         lTgewZF+U/u/HDxA1HZmtNe8hRLAmBMu9w9LrlqSUVAJr1CChq7Ado1yVn4XCoJxyFhr
         ZWz3biGVIEkjDwOw+fd8t1C/44zP32fGZGyHdMUjAV5KxORr1Xl8y8UcQwVPn1ZplZxt
         eF1426XnsHjW9YAF5huKGSAcLekG37avHWTOnVWCFWI7HhkH4nbmCtmSXt5YM31c3+G+
         DK5w==
X-Forwarded-Encrypted: i=1; AKwUvBzUwhb+fyf+QbqVXmW7sxPkq/tYCizML0s9Csj7g5VIiqrpd9wLpXhpyyhQ2UBLuUzejRA9E56uTsB8szAxw8A=@vger.kernel.org
X-Gm-Message-State: AFuF++nTU2gqCN7qtc1ZxJlF/CwGADzc40wYbqkoMjzuxCnciNRXgbBe
	FT3TNds7H32F5Q1DUMWQ4vQl1fqg0ceEcbiUgH49qSMQche5ipHiZNYQS7UVZjBklfIFbwlkXbF
	3DHDFlbqjyEfRlKdeuVUjLdd8HD8VjtdHfXLcoAvO44V8RaJGEcO1ZtyF6nfCKlollMu32dU=
X-Gm-Gg: AYBFou1giuUWxgk25exNCKrbGdsmoj9ASYR1SCsMIdrYLLH2cjTP6mlmVEz+V7+F42I
	NcM1Mc1PGldwVoFYcW5DVq5WvwBHbUj14FlSAOd6GFPUHu7AXb1Tr+Jn4pmgLXGNV9XQ25OsFFK
	2K0hhpcZEM0336dlWzN5QexesD524QCTEOcvfdTpc9EGTqXFIb5RMaVqOp4FkUYIQNCo/BVq5Tk
	eRVKEtUpaYigUeNshmNkHxR5uCVKVedpPdMirEZsFIl6pViHmumuO5H0yH4GrJT6j4Cmr2KeLnB
	SW9U9c2D/JrOufOiH82M/HMCUogdpGgQJMDAS5W/Azt3xiedFCO1p8VTRlezWTd206su1ISefWZ
	ZhJ87IriX4tH6KPDAbCwgXJ6EQpsTnkB0famhq6cF32g0NsujMIHSvOvDtJ9RhCvSKapRShConw
	ZmGU+/H+wyH2j7FJakoB9m4sEdj+J9yEyTySzMLeGt2kGKrwSqwPA=
X-Received: by 2002:a05:6102:914:b0:79b:b116:2c5 with SMTP id ada2fe7eead31-7a55ab35ab4mr5546399137.2.1790005006918;
        Mon, 21 Sep 2026 08:36:46 -0700 (PDT)
X-Received: by 2002:a05:6102:914:b0:79b:b116:2c5 with SMTP id ada2fe7eead31-7a55ab35ab4mr5546354137.2.1790005006407;
        Mon, 21 Sep 2026 08:36:46 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:d5b5:76d2:82e3:e5fb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd07bba7sm231054065e9.9.2026.09.21.08.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 08:36:44 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 17:36:25 +0200
Subject: [PATCH v8 5/9] media: Documentation: uapi: Add qcom-camss ISP
 params documentation
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-camss-isp-ope-v8-5-dd1c86a3c8a0@oss.qualcomm.com>
References: <20260921-camss-isp-ope-v8-0-dd1c86a3c8a0@oss.qualcomm.com>
In-Reply-To: <20260921-camss-isp-ope-v8-0-dd1c86a3c8a0@oss.qualcomm.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bryan O'Donoghue <bod@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-hardening@vger.kernel.org
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=aJ9lOr9m c=1 sm=1 tr=0 ts=6ab14f10 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=Nff7jVtaK1xTle8F27sA:9 a=QEXdDO2ut3YA:10
 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDIyNyBTYWx0ZWRfXwIMWAKrn81dS
 GNn2xrT7Tg0gipXbSFUZpgZEnXvZrhQWJVfjufc5wgjVWhL9TfVPaTK+WACR+p6qSg39ipKvTNr
 IlXhjk+DaxA7y0P0lwBv4VTuxy2+eW0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDIyNyBTYWx0ZWRfX7FnPrn8mXXNp
 oTFX4fmeDSYYvVy18s5wyV44vJE/pDbAZIC8/Z2xgGxtHEFcZyvGBus9dXfxvhvFUhpotqEqCwG
 aeS1+9bMZg+hUx/XsCWN4hj0tZSOBKS6nPOu411HSZFjU0u+TUeh0s5iZ14TdfZ+8dRUgstXBpY
 kouBd46MkMIltNwSYRmZ7DOGpaey1GEhROLwhHzjRJDv+jxZmhA+57xLzduVG+oUdJ5hOexSH8G
 OAPjWCQBI8vEUw/STqVXlaCwOJ2OqssM5is3bwY7HMj3vkVFaE7bLtm92NtFnsvaARDoXZKCm4H
 4jKupwGhRdRdYBk0pdDnk6IUpqMMCHgZlKzeqU4xn+UqQ7DQ/z/nPROvPfCukAe1QfvITv9lV/d
 n0tDofVdr2p6vTq19RvsCIXpqxIBryYGbUHsNoyqYl1dnVBnsxHtTAtpUBd20vTVtt08c3Sd8lc
 E13ccKwdDEdqMhvVIjA==
X-Proofpoint-ORIG-GUID: gUNS_yOIhzF3ZO9X6xAZ25kUGkPFo3ip
X-Proofpoint-GUID: gUNS_yOIhzF3ZO9X6xAZ25kUGkPFo3ip
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210227

Add documentation for the Qualcomm CAMSS ISP parameters metadata format
(V4L2_META_FMT_QCOM_ISP_PARAMS). The format is built on the V4L2
extensible ISP parameters system, with per-block structs defined in the
qcom-camss-config.h uAPI header, and is designed to be shared by any
CAMSS ISP engine exposing a parameters metadata output video node. The
Offline Processing Engine (OPE) ope_params node is the first consumer,
with additional engines expected to add their own parameter blocks in
the future.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 .../userspace-api/media/v4l/meta-formats.rst       |   1 +
 .../userspace-api/media/v4l/metafmt-qcom-isp.rst   | 150 +++++++++++++++++++++
 MAINTAINERS                                        |   1 +
 3 files changed, 152 insertions(+)

diff --git a/Documentation/userspace-api/media/v4l/meta-formats.rst b/Documentation/userspace-api/media/v4l/meta-formats.rst
index b5455229837e707c24e134438d5e2fd12cb3bf37..25b46af4d9f7faab37000076c530e9aad5b4a076 100644
--- a/Documentation/userspace-api/media/v4l/meta-formats.rst
+++ b/Documentation/userspace-api/media/v4l/meta-formats.rst
@@ -20,6 +20,7 @@ These formats are used for the :ref:`metadata` interface only.
     metafmt-intel-ipu3
     metafmt-pisp-be
     metafmt-pisp-fe
+    metafmt-qcom-isp
     metafmt-rkisp1
     metafmt-rppx1
     metafmt-uvc
diff --git a/Documentation/userspace-api/media/v4l/metafmt-qcom-isp.rst b/Documentation/userspace-api/media/v4l/metafmt-qcom-isp.rst
new file mode 100644
index 0000000000000000000000000000000000000000..5e1fd5814ff788327689ea8398a17b90b4ef33bb
--- /dev/null
+++ b/Documentation/userspace-api/media/v4l/metafmt-qcom-isp.rst
@@ -0,0 +1,150 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. c:namespace:: V4L
+
+.. _v4l2-meta-fmt-qcom-isp-params:
+
+**************************************
+V4L2_META_FMT_QCOM_ISP_PARAMS ('QCIP')
+**************************************
+
+Configuration Parameters
+========================
+
+The ``V4L2_META_FMT_QCOM_ISP_PARAMS`` format carries image processing
+configuration for the ISP engines found in the Qualcomm Camera Subsystem
+(CAMSS). It is passed to a metadata output video node using the
+:c:type:`v4l2_meta_format` interface.
+
+Rather than a single struct containing sub-structs for each configurable area
+of the ISP, parameters use the :ref:`v4l2-isp` parameters system, through which
+groups of parameters are defined as distinct structs or "blocks" which may be
+added to the data member of :c:type:`v4l2_isp_params_buffer`. Userspace is
+responsible for populating the data member with the blocks that need to be
+configured by the driver. Each block-specific struct embeds
+:c:type:`v4l2_isp_params_block_header` as its first member and userspace must
+populate the type member with a value from :c:type:`camss_params_block_type`.
+Populated blocks must be placed consecutively in the data member, and the
+combined size of all populated blocks must be set in the data_size member of
+:c:type:`v4l2_isp_params_buffer`.
+
+The set of supported blocks depends on the CAMSS engine consuming the buffer.
+The block definitions themselves are shared across CAMSS ISPs; currently the
+Offline Processing Engine (OPE) is the only engine consuming them, through its
+``ope_params`` metadata output video node. Additional engines and blocks may be
+added to this format in the future.
+
+A block carrying ``V4L2_ISP_PARAMS_FL_BLOCK_DISABLE`` bypasses the
+corresponding hardware module. Any other block updates the module's
+configuration and leaves it enabled. Blocks omitted from a buffer keep their
+previously programmed configuration and enable state; until userspace submits
+a block for a given module, the driver's default configuration applies.
+
+OPE processing pipeline
+=======================
+
+The OPE is a memory-to-memory engine that reads a Bayer RAW frame from its
+``ope_input`` node and writes a YUV frame to its ``ope_disp_output`` node. The
+parameter blocks configure fixed-function hardware modules that the frame data
+passes through, in the following order:
+
+.. code-block:: none
+
+	 Bayer RAW in            RGB domain                      YUV domain      YUV out
+	 (8/10-bit)   +------+   +------+   +------+   +------+   +------+   +------+   (NV12/NV16/
+	  ----------> |  WB  |-->| DEMO |-->|  CC  |-->| GLUT |-->|CHROMA|-->| DSC  |----------->
+	              +------+   +------+   +------+   +------+   |ENHAN |   +------+    NV24/GREY)
+	                                                         +------+
+
+The stages, and the parameter block that configures each one, are:
+
+.. flat-table:: OPE pipeline stages
+    :header-rows: 1
+    :stub-columns: 0
+
+    * - Stage
+      - Module
+      - Parameter block
+      - Function
+    * - WB
+      - CLC_WB
+      - :c:type:`camss_params_wb_gain`
+      - Per-channel white balance gains and black-level / pedestal offsets,
+        applied to the raw Bayer data.
+    * - DEMO
+      - CLC_DEMO
+      - *(none)*
+      - Demosaic: reconstructs a full-resolution RGB image from the Bayer
+        mosaic. Always enabled; not configurable through this format.
+    * - CC
+      - CLC_CC
+      - :c:type:`camss_params_color_correct`
+      - Color correction matrix applied in the RGB domain.
+    * - GLUT
+      - CLC_GLUT
+      - :c:type:`camss_params_gamma`
+      - Per-channel gamma correction curves (256-entry LUTs).
+    * - CHROMA_ENHAN
+      - CLC_CHROMA_ENHAN
+      - :c:type:`camss_params_chroma_enhan`
+      - RGB to YUV color transfer matrix.
+    * - DSC
+      - Downscaler
+      - *(none)*
+      - Chroma (and, when required, luma) downscaling to produce the requested
+        YUV subsampling, e.g. YUV 4:4:4 to 4:2:2 (NV16) or 4:2:0 (NV12).
+
+The input node accepts 8-bit and 10-bit packed Bayer RAW formats (for example
+``V4L2_PIX_FMT_SRGGB8`` and ``V4L2_PIX_FMT_SRGGB10P``). The output node
+produces semi-planar YUV (``V4L2_PIX_FMT_NV12`` / ``NV21`` / ``NV16`` /
+``NV61`` / ``NV24`` / ``NV42``) or luma-only ``V4L2_PIX_FMT_GREY``. A
+configurable stage is bypassed while its block carries
+``V4L2_ISP_PARAMS_FL_BLOCK_DISABLE``.
+
+The following example populates an OPE parameters buffer with a white balance
+and a gamma correction block:
+
+.. code-block:: c
+
+	struct v4l2_isp_params_buffer *params =
+		(struct v4l2_isp_params_buffer *)buffer;
+
+	params->version = V4L2_ISP_PARAMS_VERSION_V1;
+	params->data_size = 0;
+
+	void *data = (void *)params->data;
+
+	struct camss_params_wb_gain *wb =
+		(struct camss_params_wb_gain *)data;
+
+	memset(wb, 0, sizeof(*wb));
+	wb->header.type = CAMSS_PARAMS_WB_GAIN;
+	wb->header.flags = V4L2_ISP_PARAMS_FL_BLOCK_ENABLE;
+	wb->header.size = sizeof(struct camss_params_wb_gain);
+
+	/* Unity gain on all three channels (15uQ10, 1024 = 1.0) */
+	wb->g_gain = 1024;
+	wb->b_gain = 1024;
+	wb->r_gain = 1024;
+
+	data += sizeof(struct camss_params_wb_gain);
+	params->data_size += sizeof(struct camss_params_wb_gain);
+
+	struct camss_params_gamma *gamma =
+		(struct camss_params_gamma *)data;
+
+	memset(gamma, 0, sizeof(*gamma));
+	gamma->header.type = CAMSS_PARAMS_GAMMA;
+	gamma->header.flags = V4L2_ISP_PARAMS_FL_BLOCK_ENABLE;
+	gamma->header.size = sizeof(struct camss_params_gamma);
+
+	/* Identity curve (pass-through, gamma 1.0) */
+	for (unsigned int i = 0; i < CAMSS_GAMMA_LUT_SIZE; i++)
+		gamma->glut[i] = gamma->blut[i] = gamma->rlut[i] = i;
+
+	data += sizeof(struct camss_params_gamma);
+	params->data_size += sizeof(struct camss_params_gamma);
+
+Qualcomm CAMSS ISP uAPI data types
+==================================
+
+.. kernel-doc:: include/uapi/linux/qcom-camss-config.h
diff --git a/MAINTAINERS b/MAINTAINERS
index 3a19da74d00c9dfb48e900df71a86d4686d3ec2c..b5593f814b60fcbcd88f4b4aad25880d19825dc0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22363,6 +22363,7 @@ L:	linux-media@vger.kernel.org
 S:	Maintained
 F:	Documentation/admin-guide/media/qcom_camss.rst
 F:	Documentation/devicetree/bindings/media/qcom,*camss*
+F:	Documentation/userspace-api/media/v4l/metafmt-qcom-isp.rst
 F:	drivers/media/platform/qcom/camss/
 
 QUALCOMM CLOCK DRIVERS

-- 
2.34.1

