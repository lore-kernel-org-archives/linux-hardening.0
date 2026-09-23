Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896E148C8A2
	for <linux-hardening@vger.kernel.org>; Wed, 23 Sep 2026 16:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790179245; cv=none; b=YpfmpyUzq0H8Ip8MJLAIVZ/JkZdM1zkuY4TQE8VXN+NzskI081g+IMidgvv3i+xmn1g5bBHcxe/yey7Dd+Gq5Va5ukqet+xeNBS8OShSjTfkOFJn8I3QbbJd260LaBPpeI3R9aSpoa/ngjnUy6VIgl7vDQKblXegGOEwWGZiD3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790179245; c=relaxed/simple;
	bh=FBaxmp4RMgRnrPItYfxrye8DWG+UjGhnzM+Jbssrx9s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GpWy+4V9M+KSSQCIp2gLFNW9Temu3fW/04T9Y/N7y5KUQhIKgDMHDWLKvK6CXnFHWdIkrUKZhRdi6SDfX4nn67B/l3MNUcmDVyJQ8aYiB1Lt6q5HOJl0fbFutB46leWohhGB6iV+nF9OloRv0o3qwTdwc3gIg4REVaRKZYR4lTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TJs6l51w; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QaReYhKe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TJs6l51w";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QaReYhKe"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68NDKqCJ2056314
	for <linux-hardening@vger.kernel.org>; Wed, 23 Sep 2026 16:00:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ezSgm0eHPd43DlPu4NAZMO75tx3TP1BnI44kHNSTRVA=; b=TJs6l51wFF71pUXP
	WVzuFPblkshUH8NE/Ut2tr1RGLhc4NxlPVcfm3Ws/OkbRnOiAoSq9MyYPajW6nSF
	iJJHH4JCvUCG3Rsu9xIBstGBRxO8i5PrGC6DDAMigr9SqwPqGxzwuv9hYKAzP+ey
	wUWuFrwTk4dpbUL+jGIAIk4oEDSAmDq1LX4VjFYOODu4DbGGabuQECmpxbr45oGJ
	jc99H2VcdarNb3gGnrVPy7IP+GlKYctUFVGmmjhEEwF5d7LLpQT5c5JpnIwZiqPA
	7rdNffoh2DILimJilmhImBu3PugPnolxUHPxVkRk1jExwBIdglA+0N/jtzfB2VOL
	Bs2whA==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvfjv0qks-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Wed, 23 Sep 2026 16:00:40 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-5c83007a11cso447113e0c.2
        for <linux-hardening@vger.kernel.org>; Wed, 23 Sep 2026 09:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790179239; x=1790784039; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ezSgm0eHPd43DlPu4NAZMO75tx3TP1BnI44kHNSTRVA=;
        b=QaReYhKeymZJYShtytMH6BjgMymcNnWeRpBOcLowqakx7zPhxBxnBz0RpxXSe00IVo
         /mRZhRU4bv+GRby7Xn2aMqG5LDdt1SC1VzoJoeOS9JHF6r2SvG3UEtIgNG0hbu33mr3+
         XRy8kq+llRCf/Uu4AWunGgB25fxs6yyYcbQY04nazmo7JzEKHcTwpc9FDYRe6SD5U5BN
         bFr+thRyT2hgwsKaRDrxtKYyHfD3F7lOZZyM7lh6FhYca85k3RQDiIitNUnImZo5qpC0
         4yT92E8/eYBTtdPW7UHSFKk+TkXLch51VOryyA8VkRsxcDi19dFq7ex0krKYuMDrt99F
         0gQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790179239; x=1790784039;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ezSgm0eHPd43DlPu4NAZMO75tx3TP1BnI44kHNSTRVA=;
        b=pDZaoJos/7zSoA6Y7TQRfYcHeWu8xmTme0miDu2MHy15aaIsdwl58Y1LBbzi1t3LvD
         o9PC77ufNzwOFiTXiql5O3nLF5FrqA6k7UcUfb7CznNx0r4dTsPi1SjtNoRgrOTsH5vb
         xMWmb+VA9KAVFQuVGGtmcgK78/g9DjRB88PVy3V397OxtIsnzr4Pz9SfSE5vP/O41nO/
         CvaqJLRvQTbmK7ilS20qQIE78ut1eBj7wP1/rWtG2bINSWuMgmMnWQCKdzpFFRzbrtBl
         bW+H9MXk/IjF7+2MdHgA9rB3aFmAnERbUZc9um9yalKark6jQQkF6+4CYffwbbu4RcTq
         29VA==
X-Forwarded-Encrypted: i=1; AKwUvBz4Jh3B1Ih2IYdA9S1ETNOo6y2y0aAOdK0YBRZ5BMzIXJ9FwaCgvahV3MkA4r10x6eDuUxc5yK3VdAt2F0GyJE=@vger.kernel.org
X-Gm-Message-State: AFuF++kwWNbw4nivBzy7VJoLfpZqakVWEvAmB2HXtTotWueEyOcr7+ek
	w63mV0Q9Ly4GUtBQ7QA358HxGnGh0y3MyN1k4jZvT3xa9/4V2fpCPZHXUZfGx8P7sEjATstxHjs
	g4y50cYKT75eUTe2C6cTn9U+uR1DE5jlCaHjXPXTRxNBfmFEjmu8WOj6k2tvPxqjImn2teEA=
X-Gm-Gg: AYBFou1g66TpMfYDRtb0l57R/4A7NUvcSGBSuNXsClVJDWB22Cwq16gQoSo+ltvNxzs
	1+uCUr8M6rDPCxLicZ/AihT/jBHnx1DHB1LQhlqng8MKUE7XBUsc/btKOWSamHKWdqlaMNiOtiJ
	vOcVBkLW47ZkUBf1y6WV5TWcbq2UA14xkjQL6hIcdPCr/WDcclQSsboF1N+oHXF8fNcLCA1u5y2
	IJEzhxnbnnUoXy57JvVc1FhKvrfq+Q0T2Jtx9UbkaICU4U++44fRvI0oh00bgla2+eY5CHR87fY
	8UptR0pPoKhWWKTGWsQdhLl+F3c9rFHk0x9ZVGsqBxlsW5yEqaLlCoK7p5U8V38aBiDGLo0PSzs
	T2whvwOxGOy6a9cEBeGopBSf4A2M53nm2iwMgfBY4xE9zyZR4iprBRgQgEVe4r70Iad67ki7WGT
	HAVi/4mXT8b+20w1RTaz0rE+pcx4yYQjsNtyky7v/s2O+GOQKzh0fBjLL/xiUy+g==
X-Received: by 2002:a05:6122:6e09:b0:5c9:a60b:e5d8 with SMTP id 71dfb90a1353d-5c9f168afb0mr3578417e0c.18.1790179239089;
        Wed, 23 Sep 2026 09:00:39 -0700 (PDT)
X-Received: by 2002:a05:6122:6e09:b0:5c9:a60b:e5d8 with SMTP id 71dfb90a1353d-5c9f168afb0mr3578304e0c.18.1790179238424;
        Wed, 23 Sep 2026 09:00:38 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:d5b5:76d2:82e3:e5fb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fde197466sm80739325e9.7.2026.09.23.09.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 09:00:37 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Wed, 23 Sep 2026 18:00:26 +0200
Subject: [PATCH v9 5/9] media: Documentation: uapi: Add qcom-camss ISP
 params documentation
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-camss-isp-ope-v9-5-86a75dc18b83@oss.qualcomm.com>
References: <20260923-camss-isp-ope-v9-0-86a75dc18b83@oss.qualcomm.com>
In-Reply-To: <20260923-camss-isp-ope-v9-0-86a75dc18b83@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA2MyBTYWx0ZWRfX0ROQnJr/45JB
 Besd2Dp8hGh/0oRcfNyYWbjsHQX6iHFm5jdmElNomV/1M8ODRbc/6Lik1Y4a2S6JVCvbXnmFvgW
 YnnYUj6EDhytjCitDWFPlHCKYourwccqUl/XyF50mSgD3/WR1/dv3/lLBl7YdNb+JJG8MHg8uSg
 BA6k+Rue2PUZkGL+CsGaVHja89O/WRBrGYixiyBPdx2W0C9gWAXYsn4//7HjrJc7tF6NJTu0DwC
 2vbFvA/HpMtNubMWplSQO3clCbWfuvzxMJaR1qvVcoDbTEloiJH1Ck+NNYaHP3rv8V4M7H3K2Eo
 K0y6lHtVobvoZhSPRaJQfruX/FkD6ilFM8R9HiX8Y2lV8twm+hhK+aFdzd8gtpXiTcXE0KpQvw2
 Md+eN9exufWnK3iAd1CzWTKFrQrfFTgc013WqwaGS0cLkaAjdQzjOGsxJ7l+wK/Yniv1T7Y9h+V
 7jGNn0uYtjckUdOxRxQ==
X-Authority-Analysis: v=2.4 cv=aIxlOr9m c=1 sm=1 tr=0 ts=6ab3f7a8 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=Nff7jVtaK1xTle8F27sA:9 a=QEXdDO2ut3YA:10
 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-GUID: 5NN3sFjBzF1flWpK6KWGVLhGDmuY-otf
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA2MyBTYWx0ZWRfXz0/daD0amh6y
 PQuitM3RnVZgZjRUZddM4ZAveW+oayg/OoiLFeJw5nFNh3T3X0iFq9vI9AO4m+1Fvmm+AzGHXOK
 pmKaPQWgGR5+4AVinZJaHA0HFRtHXbk=
X-Proofpoint-ORIG-GUID: 5NN3sFjBzF1flWpK6KWGVLhGDmuY-otf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 spamscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230063

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
 .../userspace-api/media/v4l/metafmt-qcom-isp.rst   | 147 +++++++++++++++++++++
 MAINTAINERS                                        |   1 +
 3 files changed, 149 insertions(+)

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
index 0000000000000000000000000000000000000000..2f3654a9ba897d0d1481d38a7117be8e84b1a99e
--- /dev/null
+++ b/Documentation/userspace-api/media/v4l/metafmt-qcom-isp.rst
@@ -0,0 +1,147 @@
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
+	params->data_size = sizeof(struct camss_params_wb_gain) +
+			    sizeof(struct camss_params_gamma);
+
+	__u8 *data = params->data;
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

