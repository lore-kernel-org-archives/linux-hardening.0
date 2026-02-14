Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E4930C62B
	for <linux-hardening@vger.kernel.org>; Sat, 14 Feb 2026 12:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771072812; cv=none; b=lRNLQHbxpHvnYEmtJLTrqiHu1YiTWS1TrQwvFwXLvhrkxr3afrpCg3DHmPkz4n8W0p+hDpUyMNuVb0qhgdgwpVsDlGflRfzH1qg4UhkfqA7koD1pG3X2Zjz19feSHubrTJnd7moq1SaOs/fPWmVGsjpH9L91v6HednYtGV6v0h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771072812; c=relaxed/simple;
	bh=7feOF3Elx5oK8syt/T37E03ztwOdUNRtuaEPtI7X4x0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n5QqDjfLtzD3nlDX7qXMdlI0/WYo5Cc+uzPSLDxWZl99FZDSTzQWHX0BJ8DXADr/pr49/Au8/dPSxp/GMvalrAUthj1VIlA9g5knkjT2QfZRhv+1TkPqgf9P7LeIizOXFlV6DIvQJVPhgOYYeoOijNH8cuH//3phdWYclBA/14A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ai2jgxSK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AS/vNaOj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ai2jgxSK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AS/vNaOj"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61EBTnKg2440609
	for <linux-hardening@vger.kernel.org>; Sat, 14 Feb 2026 12:40:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8ChNQ0sN5/DiYoC6u1SEgcPiH2YqmBHOxmwxzvZzWz8=; b=Ai2jgxSKwmRCG6r8
	DW/fxS+YPGAouZGxpiQO/NZLMVYFsZjjTfKUvwhpb4i1v9NAi2/8odqFMFlBSWGZ
	jfBVf+/0gDoersUXBs6kCfzrmxnGFh2vm/Tn/p4wyKuNcHoXx8sUxArgzGJw2ANT
	326lP+MKVjF1QG56xENQ8OFRWaEO7BpwXBj56zhIPPRq0sV+6Sc42zxh1h4wN4h/
	1UJbOBbYbMWBeFh5QHHupxzmiMmMrJj3Y4jFyDb6qJkMnn9JXy4LKoJUCrMWqQVv
	6Ei4kiLPhp/R/pDzb4dqcBuiS7K3N/LaogASUzkj3QuZNLGkhSQ9Boo3O0w7VdO0
	jpiC3A==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cahe60pkw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Sat, 14 Feb 2026 12:40:05 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8cb3ad1b81aso1066664485a.2
        for <linux-hardening@vger.kernel.org>; Sat, 14 Feb 2026 04:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771072805; x=1771677605; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8ChNQ0sN5/DiYoC6u1SEgcPiH2YqmBHOxmwxzvZzWz8=;
        b=AS/vNaOjUjxjDUpBgjr4U7/VLOyNkax4Hq0YYG9LJXuQ7Le/HvOX5ao8QMmUesYUfb
         Lz4CXUtUeWGfaRJeoPISkQeAl2D08gRVfgE47pVcqOUE6a/SuEkjVVtonLD8tDf13MGR
         MsDYlIHkad5fX/zukJw6DYbo7LIaUE8KB7ysj3m9ubbWy1AWwK7bA487uys+XSI+nUH9
         7J/rYMmGAf1k83ZDt4NuRjGCWHOrWPJ8wLpurCA2OOtOAL4PbVHegicWErshH7VswVDL
         pbVoFGAzGyyifvArsshsJCj74K0RQ3Y0E1dULdDyTw4G5DUnnZTfQMxgW/ARYLwmnMGZ
         A6Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771072805; x=1771677605;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8ChNQ0sN5/DiYoC6u1SEgcPiH2YqmBHOxmwxzvZzWz8=;
        b=ETZL1fb1axInDwRSIp4DtqipfX6H46IzXQSpEw+nYpph7M6UWjRhjgYsLoqPA6P1lL
         REON00ASAT8jx6RSm95WVKdsleBWUu+J1HL7cz4Bm7gd4B+SLKlDSgH0LijEM/d3Jd3B
         m7eypwrzfbobxO8kvzwbgdF0FhE/N6QFwigMLt30wBIKM0CQmZOvjC5ngTuDRNgwSQI8
         BwHB1h16P0AEOM4QkS3BiYMYzR576TlKd1ddgyrOoWaUheE+HLlOPS+PNsoNB0kpmc5W
         OGrDk46QZY5kYrCAPkKOlRdPAN5nDAEAi8qD/VfnhoUAV4QLlgK4kng6MqqFd1BH/+yY
         RFdw==
X-Forwarded-Encrypted: i=1; AJvYcCWG60of8p+Y13s08qF/TeZRy0mYaeTIMuLRyLYl5fS3OCtnKiJyuh3Sa7T8qDiHLrN6qcP/zACBFjZOsj1QTvg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyct5G9JkSHkDYIeT+eiqzkkU0fhhzE0y6BbWBj5wBtxTZDMxkX
	Zvixdf4OEqxInWLMAaSwmKSsqLanZ4jzb6Qwmjuc2orjhEYCYHk9zDtncAlqwlu+tGGJp7LdnjG
	kUBUwoX2TE1LsgWBJhxshJTsfOuE34qFQhJPCuihYt4ilbPLVcBwIFxVYEg7WsFY09HGprtU=
X-Gm-Gg: AZuq6aLyIb7qGwr2iRgWa9uG0JW4cEgp3wQSRz/V/1ZI8blzOGKE949nOdDVLQXgR8w
	6PSPFentG7RlYnfYAFfs4DyRiWtAxKsKaWUUjwk1QSZ9+EbQULTG4YERcpMAgXRwOBEECvtilD7
	7J3BNr1vmqWd/aE5BRwVFAcUGjF1riJeUIQ1Zg0XYU7CIbK0u5CWJYjVo3RUpz/PmmTgML4Jkqx
	PVIffj6vjqBzGihMXmDNAlgqx1iaK59SAZ/w9FYd5ikZfWM8Mb6eHULEGXoU/rz3JoZKMnoHyYm
	QUIf+prxwUTo6CnvOjKIKllmyRdxOHeRAZQJpgBsi1XcpIlMhnIL9R9BgZDTwv0jk8OWer+oe28
	SfIG+A1nliYFUQH/eqH9e6+V6RXdVCibl3PpwkCn5hIwZhw==
X-Received: by 2002:a05:620a:471f:b0:8ca:2cf9:8197 with SMTP id af79cd13be357-8cb4c01475amr339890885a.47.1771072802767;
        Sat, 14 Feb 2026 04:40:02 -0800 (PST)
X-Received: by 2002:a05:620a:471f:b0:8ca:2cf9:8197 with SMTP id af79cd13be357-8cb4c01475amr339889085a.47.1771072802231;
        Sat, 14 Feb 2026 04:40:02 -0800 (PST)
Received: from [127.0.1.1] ([178.197.223.140])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796a5ac87sm13644215f8f.3.2026.02.14.04.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Feb 2026 04:40:01 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Sat, 14 Feb 2026 13:39:41 +0100
Subject: [PATCH RFT 2/3] firmware: exynos-acpm: Count number of commands in
 acpm_xfer
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260214-firmare-acpm-counted-v1-2-32af5735470e@oss.qualcomm.com>
References: <20260214-firmare-acpm-counted-v1-0-32af5735470e@oss.qualcomm.com>
In-Reply-To: <20260214-firmare-acpm-counted-v1-0-32af5735470e@oss.qualcomm.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org,
        llvm@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6706;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=7feOF3Elx5oK8syt/T37E03ztwOdUNRtuaEPtI7X4x0=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpkG0b6OQvxeirc2xuqsfeyQEzVUkBzADwwpMdt
 WS9g5qUQbaJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaZBtGwAKCRDBN2bmhouD
 18GJD/9TaH0D1uNgkwpVn6l0/zxtSfyRi2kkO6reLHLEwbL6l3EAhGf2aqRrMDKDyh7UQQgRgB9
 RY7fSQAvdAydKnS3ovDFWBxPG6ZU7CjdtwBhZTE4Fet85+ea1bEpUodQRU0CRHNAIZ3nYhaDyIM
 OoDGk8VNryGEJ4nPBM0yiMNcOrQ0oatdASHxa+yzniGTpQWN8vdyVM5ktYa0I7k+hIZ9lx6+3SJ
 myQ1+r+0bseAVdIhbjSIAWzPnAPgUG7/2LBafX4VYyc5eJ5jUOIj5ilSt/h2w7Glb8JzB79PRGj
 QiopKUag358Y7yIoyKEgy/J2SQnasD5H7ldXjMN1Oucs739Gd99S3A2H26zUI95mG8qDLM7H+jq
 8M5cU3k9Qw+1Kr8OLrA/naH/r76e9m7LuKIr9dumQG+J9oC7UL7Z0HFHOMSYHQmoUP5h/eJPDLn
 tyqAPkS+u0cOZtEgwBs57KtOkzUAMf2+NJ+85nY21Lc2/W1ghBQfO97rXGx0+Ok8OdYTw2a370l
 4cCuvLueN6PVEW0DDhQiPp7rtDKD28Fd0pVKvXhGSq8DwZ3Gh5/Fi2el7yJLiGmdC1JfY1AAS34
 RCcDuTeSRlCKzA9jdJhtxx6nkFahFqT4F2ORhmEDpGMsNrK8XeWgYt+D/YKeON9gloCbQATdY0/
 R10iR4/b42Ku3/g==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Authority-Analysis: v=2.4 cv=c5WmgB9l c=1 sm=1 tr=0 ts=69906d25 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=6nO30s3o7FuWeffXwhKHTA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=EUspDBNiAAAA:8 a=1M7bLk_J3U762fdM4B4A:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: _1tSAhn5_BOiPvMTv4buN1VJoP_gsAOv
X-Proofpoint-ORIG-GUID: _1tSAhn5_BOiPvMTv4buN1VJoP_gsAOv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE0MDEwMiBTYWx0ZWRfXzobidBMpg4tC
 5t8dsyHbQ62Hn2a94DxF/NoiNDBfT32gfDVorT7Fqgi6c5S/uMzf4i5pD1up3hJg4lj/RQk5whf
 fWt8YDAOKHI/q3s1fKKhXbehCJreLEt2f0RfOzTZVGEGsbsyzTPXywb/5Iks2lxtpAy2sHa7Vgk
 AVNQHQCYRL/dlr/tiL2XLON0qp4g/bSSY+KzxPwavPEzGJrD70eA6HVFHdAnXaJfjVkRhdEkCGf
 5pOKGjUAjL0L23LZel1B/ZYtCl2cKAQbYCYzjhLMxplOeFBLK6DHQtN0yxJk76TwmzIgac2yQrl
 zAn0TGyFDEtmdobUZGzMpLzPXpApbai3LDE437111dIXnlsOUiwtUVT9mEDn/Xz1cy2+IeWgoVG
 tjHJ6LKR0ISaQYejEx3AUn+8IRAo7kXSdzmxLe7u3Sws8qMeNP5znf2dNgdJLAMadPQarTOtw3n
 RNAU3m/eYLFezQkSBiQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-14_01,2026-02-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1011 malwarescore=0
 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602140102

Struct acpm_xfer holds two buffers with u32 commands - rxd and txd - and
counts their size by rxlen and txlen.  "len" suffix is here ambiguous,
so could mean length of the buffer or length of commands, and these are
not the same since each command is u32.  Rename these to rxcnt and
txcnt, and change their usage to count the number of commands in each
buffer.

This will have a benafit of allowing to use __counted_by_ptr later.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/firmware/samsung/exynos-acpm-dvfs.c |  8 ++++----
 drivers/firmware/samsung/exynos-acpm-pmic.c | 14 +++++++-------
 drivers/firmware/samsung/exynos-acpm.c      | 12 +++++++-----
 drivers/firmware/samsung/exynos-acpm.h      |  4 ++--
 4 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/drivers/firmware/samsung/exynos-acpm-dvfs.c b/drivers/firmware/samsung/exynos-acpm-dvfs.c
index 1c5b2b143bcc..55ec6ad9d87e 100644
--- a/drivers/firmware/samsung/exynos-acpm-dvfs.c
+++ b/drivers/firmware/samsung/exynos-acpm-dvfs.c
@@ -25,11 +25,11 @@ static void acpm_dvfs_set_xfer(struct acpm_xfer *xfer, u32 *cmd, size_t cmdlen,
 {
 	xfer->acpm_chan_id = acpm_chan_id;
 	xfer->txd = cmd;
-	xfer->txlen = cmdlen;
+	xfer->txcnt = cmdlen;
 
 	if (response) {
 		xfer->rxd = cmd;
-		xfer->rxlen = cmdlen;
+		xfer->rxcnt = cmdlen;
 	}
 }
 
@@ -50,7 +50,7 @@ int acpm_dvfs_set_rate(const struct acpm_handle *handle,
 	u32 cmd[4];
 
 	acpm_dvfs_init_set_rate_cmd(cmd, clk_id, rate);
-	acpm_dvfs_set_xfer(&xfer, cmd, sizeof(cmd), acpm_chan_id, false);
+	acpm_dvfs_set_xfer(&xfer, cmd, ARRAY_SIZE(cmd), acpm_chan_id, false);
 
 	return acpm_do_xfer(handle, &xfer);
 }
@@ -70,7 +70,7 @@ unsigned long acpm_dvfs_get_rate(const struct acpm_handle *handle,
 	int ret;
 
 	acpm_dvfs_init_get_rate_cmd(cmd, clk_id);
-	acpm_dvfs_set_xfer(&xfer, cmd, sizeof(cmd), acpm_chan_id, true);
+	acpm_dvfs_set_xfer(&xfer, cmd, ARRAY_SIZE(cmd), acpm_chan_id, true);
 
 	ret = acpm_do_xfer(handle, &xfer);
 	if (ret)
diff --git a/drivers/firmware/samsung/exynos-acpm-pmic.c b/drivers/firmware/samsung/exynos-acpm-pmic.c
index 44265db34ae6..26a9024d8ed8 100644
--- a/drivers/firmware/samsung/exynos-acpm-pmic.c
+++ b/drivers/firmware/samsung/exynos-acpm-pmic.c
@@ -63,8 +63,8 @@ static void acpm_pmic_set_xfer(struct acpm_xfer *xfer, u32 *cmd, size_t cmdlen,
 {
 	xfer->txd = cmd;
 	xfer->rxd = cmd;
-	xfer->txlen = cmdlen;
-	xfer->rxlen = cmdlen;
+	xfer->txcnt = cmdlen;
+	xfer->rxcnt = cmdlen;
 	xfer->acpm_chan_id = acpm_chan_id;
 }
 
@@ -86,7 +86,7 @@ int acpm_pmic_read_reg(const struct acpm_handle *handle,
 	int ret;
 
 	acpm_pmic_init_read_cmd(cmd, type, reg, chan);
-	acpm_pmic_set_xfer(&xfer, cmd, sizeof(cmd), acpm_chan_id);
+	acpm_pmic_set_xfer(&xfer, cmd, ARRAY_SIZE(cmd), acpm_chan_id);
 
 	ret = acpm_do_xfer(handle, &xfer);
 	if (ret)
@@ -119,7 +119,7 @@ int acpm_pmic_bulk_read(const struct acpm_handle *handle,
 		return -EINVAL;
 
 	acpm_pmic_init_bulk_read_cmd(cmd, type, reg, chan, count);
-	acpm_pmic_set_xfer(&xfer, cmd, sizeof(cmd), acpm_chan_id);
+	acpm_pmic_set_xfer(&xfer, cmd, ARRAY_SIZE(cmd), acpm_chan_id);
 
 	ret = acpm_do_xfer(handle, &xfer);
 	if (ret)
@@ -159,7 +159,7 @@ int acpm_pmic_write_reg(const struct acpm_handle *handle,
 	int ret;
 
 	acpm_pmic_init_write_cmd(cmd, type, reg, chan, value);
-	acpm_pmic_set_xfer(&xfer, cmd, sizeof(cmd), acpm_chan_id);
+	acpm_pmic_set_xfer(&xfer, cmd, ARRAY_SIZE(cmd), acpm_chan_id);
 
 	ret = acpm_do_xfer(handle, &xfer);
 	if (ret)
@@ -199,7 +199,7 @@ int acpm_pmic_bulk_write(const struct acpm_handle *handle,
 		return -EINVAL;
 
 	acpm_pmic_init_bulk_write_cmd(cmd, type, reg, chan, count, buf);
-	acpm_pmic_set_xfer(&xfer, cmd, sizeof(cmd), acpm_chan_id);
+	acpm_pmic_set_xfer(&xfer, cmd, ARRAY_SIZE(cmd), acpm_chan_id);
 
 	ret = acpm_do_xfer(handle, &xfer);
 	if (ret)
@@ -229,7 +229,7 @@ int acpm_pmic_update_reg(const struct acpm_handle *handle,
 	int ret;
 
 	acpm_pmic_init_update_cmd(cmd, type, reg, chan, value, mask);
-	acpm_pmic_set_xfer(&xfer, cmd, sizeof(cmd), acpm_chan_id);
+	acpm_pmic_set_xfer(&xfer, cmd, ARRAY_SIZE(cmd), acpm_chan_id);
 
 	ret = acpm_do_xfer(handle, &xfer);
 	if (ret)
diff --git a/drivers/firmware/samsung/exynos-acpm.c b/drivers/firmware/samsung/exynos-acpm.c
index 0cb269c70460..242745e8394c 100644
--- a/drivers/firmware/samsung/exynos-acpm.c
+++ b/drivers/firmware/samsung/exynos-acpm.c
@@ -205,7 +205,7 @@ static void acpm_get_saved_rx(struct acpm_chan *achan,
 	rx_seqnum = FIELD_GET(ACPM_PROTOCOL_SEQNUM, rx_data->cmd[0]);
 
 	if (rx_seqnum == tx_seqnum) {
-		memcpy(xfer->rxd, rx_data->cmd, xfer->rxlen);
+		memcpy(xfer->rxd, rx_data->cmd, xfer->rxcnt * sizeof(*xfer->rxd));
 		clear_bit(rx_seqnum - 1, achan->bitmap_seqnum);
 	}
 }
@@ -259,7 +259,7 @@ static int acpm_get_rx(struct acpm_chan *achan, const struct acpm_xfer *xfer)
 		if (rx_data->response) {
 			if (rx_seqnum == tx_seqnum) {
 				__ioread32_copy(xfer->rxd, addr,
-						xfer->rxlen / 4);
+						xfer->rxcnt);
 				rx_set = true;
 				clear_bit(seqnum, achan->bitmap_seqnum);
 			} else {
@@ -270,7 +270,7 @@ static int acpm_get_rx(struct acpm_chan *achan, const struct acpm_xfer *xfer)
 				 * after the response is copied to the request.
 				 */
 				__ioread32_copy(rx_data->cmd, addr,
-						xfer->rxlen / 4);
+						xfer->rxcnt);
 			}
 		} else {
 			clear_bit(seqnum, achan->bitmap_seqnum);
@@ -425,7 +425,9 @@ int acpm_do_xfer(const struct acpm_handle *handle, const struct acpm_xfer *xfer)
 
 	achan = &acpm->chans[xfer->acpm_chan_id];
 
-	if (!xfer->txd || xfer->txlen > achan->mlen || xfer->rxlen > achan->mlen)
+	if (!xfer->txd || (xfer->txcnt * sizeof(*xfer->txd) > achan->mlen))
+		return -EINVAL;
+	if (xfer->rxcnt * sizeof(*xfer->rxd) > achan->mlen)
 		return -EINVAL;
 
 	if (!achan->poll_completion) {
@@ -448,7 +450,7 @@ int acpm_do_xfer(const struct acpm_handle *handle, const struct acpm_xfer *xfer)
 
 		/* Write TX command. */
 		__iowrite32_copy(achan->tx.base + achan->mlen * tx_front,
-				 xfer->txd, xfer->txlen / 4);
+				 xfer->txd, xfer->txcnt);
 
 		/* Advance TX front. */
 		writel(idx, achan->tx.front);
diff --git a/drivers/firmware/samsung/exynos-acpm.h b/drivers/firmware/samsung/exynos-acpm.h
index 2d14cb58f98c..422fbcac7284 100644
--- a/drivers/firmware/samsung/exynos-acpm.h
+++ b/drivers/firmware/samsung/exynos-acpm.h
@@ -10,8 +10,8 @@
 struct acpm_xfer {
 	const u32 *txd;
 	u32 *rxd;
-	size_t txlen;
-	size_t rxlen;
+	size_t txcnt;
+	size_t rxcnt;
 	unsigned int acpm_chan_id;
 };
 

-- 
2.51.0

