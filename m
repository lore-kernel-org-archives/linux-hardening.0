Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF9B4734C1
	for <linux-hardening@vger.kernel.org>; Fri, 25 Sep 2026 09:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790327409; cv=none; b=bQtUGnEzlpuDZDvcbEzA8xDYPmhwpau/EbbwDxmU+Yi/Gp+j0C8rJBhV8j9mHRKLHP9oly53vkziltlERjY3IjCeb1etlNVEVgEkI2umjOHFV/I7LP4UmOsu1DXMfHOHOGPmlR9jVGPHELrmBaVziy8QADDG5isTqUl7vKXGNYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790327409; c=relaxed/simple;
	bh=FBaxmp4RMgRnrPItYfxrye8DWG+UjGhnzM+Jbssrx9s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tsiSk0/QkqUWKGBirliGUvoPkvvCsT8cxhN8KulMZVnI3wWUWPlPEdoQQYV6EWuYkTR7dp8MfJ6pM2q4I8+11A5PkSCfAu/UW3I+W3kIlSawhsX/8rf0iqIVteiDyi274+40gIpKHcPuDBfr196bQonO72XiZKe+75rHElouBEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E5X03eSM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Xi4Y1Hpx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E5X03eSM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Xi4Y1Hpx"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68P4YXc9208402
	for <linux-hardening@vger.kernel.org>; Fri, 25 Sep 2026 09:10:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ezSgm0eHPd43DlPu4NAZMO75tx3TP1BnI44kHNSTRVA=; b=E5X03eSMaB7dzDKg
	Ygkz5Pwe78Qa4Emy4a8ztrggFAxUG9VMhI6DY/TBh1p9XBbvWbV/NGR0ucCxl8Ei
	vaNq+Ehqtchq7qgcIps1MgnyPNY6CPux0rYdXy01TxFT+zZVFf/USOnTznFpEloh
	ysb9AtS/r4fkGIMvR7/5pEhE+rXCCEENU6hQWCij19LnTYnq7JWaUDKC3lPu1Rc+
	lF6vDlDpEROutChhHDmv3YrQtzChH3ZRR12Znls+2+KU1y14IDmxZCAlHiWJL6mr
	yFPOCFzF8Yhw2c8FkoIeQApj8TValyOTPmuc46ure4S73HN5O/EYI8C0f76pwaBm
	/UhAZA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw898tuft-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Fri, 25 Sep 2026 09:10:02 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-9393ac4961fso98421885a.2
        for <linux-hardening@vger.kernel.org>; Fri, 25 Sep 2026 02:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790327401; x=1790932201; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ezSgm0eHPd43DlPu4NAZMO75tx3TP1BnI44kHNSTRVA=;
        b=Xi4Y1HpxmsWiSPh12vxk74KxUlnWSlBBV7ZKTkds9NaekJEcNl7zNMnTSUmy2KmA8d
         kQfL+pqkg/x6iLSNe15zyF+4+ohJASKhz7j/zSUll4FzT6ScR1xT2t15Y6ykem6bgheb
         J6JX5pUyh5b9uD5iee3qZgAzjhBAxuliSU4e8C1IiRibKyK/f9gIO68kpytEDGKsHA78
         MuOJmPzT0dqjMXFwxqmy/bVcxrxqcZVlomgwqZrMo721sD/fiA6kEcI2cGN7TSCGhQWO
         Gh+bWXnm1djanSB+1jcY4T8a/gk/BCJVOuE43UkioxhG9Lz7dCwM8FtVqfsvfqf68jz7
         ZmxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790327401; x=1790932201;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ezSgm0eHPd43DlPu4NAZMO75tx3TP1BnI44kHNSTRVA=;
        b=zxILrkABvfCbPNkH7YP90/ylXeePbI4Pqq8JA/5uW9wWx7MiHsE0jou8nB6VoGJR23
         Ra7bq74FL7VGXwkJVVM5CFArqWa4nS32m/Ct2X8Is140AEXNr9lpvtTFvZCSkIduw2Ab
         M/Q/dzVGeepWdkrk6fvr1guX/N+zxwcNFdT18w9MYUKruyzwV3IrFiRwpw8NAw2XSJg1
         VDlSGfnyZJSQmGH6/ZzBfDxkgof3lVNvV7pq/aLH6Bxi1j8E663KgCKlFcmHmtagZuIJ
         es7h/ljant+sk4HkxRTc5TbmAF8hf00l7pz5WfHkRzOiOZI7HRN+x8XtFrb4fv1ifg2D
         C3RQ==
X-Forwarded-Encrypted: i=1; AKwUvBzRrH53Wx7gWX+9l6+n0l5nIk1gn1Hl388S4k13P8UFMtBhBTxDk0bQnbIgzwqqwpDx/wWPfetHq/svGTiYybc=@vger.kernel.org
X-Gm-Message-State: AFuF++nVjaIOeyCBcja3Cmqf+euTkL31Nol8B5xyyLJ8csON1vOFVGH0
	C0jkjseYBsBg5QK7XqR/W1BfFuRG2w0njQKWLKfL7ZnhZBNSTYbX4MQ3Bvg14iy+jgl/jo05mCc
	4N0YdRqzkBCK8MzvUM38j8isN2c6+PFTn1qmpA1hQEAJy9zFK+izX2KdfgfjA2sY+w55EJgU=
X-Gm-Gg: AYBFou2qMHNZfcH2WiWrVwHMY3ZhBJH9p+R40VG0o4mu5IKP1+U3nztiJZT4A+W4lYa
	tANd/TCFJqond7BMQrI6x8hu3909RlSEOTRK8EZrjZQLMcgITMkWBlYaNWDodCR/xkvXxDoW2a0
	5ctVVUXASfsCmU7fsW+VS+ssdZgojGOhfSS13H23dIEMO9VIt/sAyFx/mOMo4TBaiJFCtyMsIX/
	dzTNG2Mt7NoV5aKJ0N6popWWTHd7iPh1B39izLhT/dzWKrRr36aZ+Pj9SPEoTSaZJA1/iu13cwG
	z5Z/9/NpdVF0ww1KSFmO4SHoG+YfNbbNy3uDkScjH1PT5yfuRWurJwJ7web3XrzrlDITf37urCI
	w6ivI7DKa5G96/mfdI+pyBIaFiDDkOb/FYgLvUWB+8BCYOHu1l23I124COQHWBn0YPvSPXGFAm5
	bewUqiBbQXu+pRRJdyRVEnlAgssQ5d5MldS9D66JGEuWFQN0rfcXo=
X-Received: by 2002:a05:620a:26aa:b0:93a:2a59:2ad0 with SMTP id af79cd13be357-93c43bca4b9mr342528285a.16.1790327400968;
        Fri, 25 Sep 2026 02:10:00 -0700 (PDT)
X-Received: by 2002:a05:620a:26aa:b0:93a:2a59:2ad0 with SMTP id af79cd13be357-93c43bca4b9mr342524785a.16.1790327400462;
        Fri, 25 Sep 2026 02:10:00 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:5c1f:3897:a4a1:99e1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a34a638sm5269890f8f.9.2026.09.25.02.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 02:09:59 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 25 Sep 2026 11:09:52 +0200
Subject: [PATCH v10 5/9] media: Documentation: uapi: Add qcom-camss ISP
 params documentation
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-camss-isp-ope-v10-5-2622411034cb@oss.qualcomm.com>
References: <20260925-camss-isp-ope-v10-0-2622411034cb@oss.qualcomm.com>
In-Reply-To: <20260925-camss-isp-ope-v10-0-2622411034cb@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAzNiBTYWx0ZWRfX6Dp8PzX+r6uW
 QXWk0TyLnf5hi0qHhoJuqogL/fuOeMO09+eSJPZDx2OKECezmECp7cqJKrdJ4Zjs7dXfpdBGLK1
 +jkZgv/EFZL8t813ebuJ2Awq7LDFSxSXjNTw76s+prFoEfbDxuKlDBi5vA7jNN7gB0LROr4fYyo
 rTVN0csI3dmK7O/dZ6QwU69+RAIl4144m82SW9duULgOK7xwkUAzmaLti/5vLEC17Hveh6v/D5D
 CfPycxYnkE0QbVXQ33wI4TmZCJnHglBEQSwVPdYuf+HL2BYdZenSpGvSap+zKJHImWY8LGUErGr
 AOteGcIljWIIYaJHhuG9Vg41Xr1Oq0m3e3f4Fynht2c6vVffP/wZU+vM0cTUFvhaUk4skUvyW2O
 q8ghDjaENacwMmGmQLc2dLbgT5B6unD5zkCX4YIkdnRlqHdrXiEhh3f+PZB1PfZVZiTa6gFkNKH
 1G5+MToomhVB0mDI3hA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAzNiBTYWx0ZWRfX6i+tFxVsGrcL
 +URn8u0bFfnVTdA7q8rr+N8oAjLxcHzmRibwvZsjZsLkohXPajnT4BHWXjWi2qdq1L/a5RIpKSb
 ziz5hj+rANZgt2nlOeK2GYTLLDrO620=
X-Proofpoint-GUID: oS26G_qf8iLJrTHuJUfL2UIzcOtzyLZV
X-Proofpoint-ORIG-GUID: oS26G_qf8iLJrTHuJUfL2UIzcOtzyLZV
X-Authority-Analysis: v=2.4 cv=EJWTQFZC c=1 sm=1 tr=0 ts=6ab63a6a cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=Nff7jVtaK1xTle8F27sA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 bulkscore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609250036

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

