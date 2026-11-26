Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795685788;
	b=pBrr9cMi1x/SZ5SB+pBUKwoaKtm1l6Ji37th5Y+x+fqCgGPOSfRUVuD4IGzLv0azyCBA
	 lPCoP0xfHt0zLcSdl4e2xPmeJn/Iw8OcELngT6CwRoooUAB45NinyqGn8z/X+T11sEpJr
	 N2d7RUg9pofXVtA4WYmf6SROG2rtF2IP8OBSC7mGn1G+zMgnkE4l0Z+xifbrfbK136FgE
	 6xdpyuAXFeurkZTs0KM/Vfb9/Q2AcguVvHfRO+xc3wW4kVYHDq34zc8LX0ldHWp08PX4N
	 0a1fpXOl0riN9Iy7iM8+9N6RopqK5xVj0iJEBTBrdk26TWyoz6RAyVVSRDLc2Io/SVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795685788;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=05HkMf4ygIqtlQzRN7ZbpqVF0GJOazAPdTl6j41Coks=;
	b=KajI/oWdaKFyrXT5YW7I1XsFfwxiU+Rag06K44K1smcNFJHkB5s2r7csfXSQhLaSg86V
	 B+49nyLVa8Y3Ic1VSt5y87kp5D8lUnIQV5cfmrADDGQIFANirXvrTO/AgxyB4+WZScY1F
	 rn8AnQddemQP2/5mS/JjLuQIPmF6hb93uP5QxyxtsA+iPf2UVxMU59n6UAPVXmV43xudb
	 kHFe6RjWnszQO7kbG4sxY4dlAK8bxkC460BBgDwL3rxHC9f9LxvNfAh/9AUVKJ2ZArs4o
	 S4LG70l2RnWVTfQcJh/XrazMPqn+8ojXwiUzplbgMI8uBiSWvwNVXijI1nQyb10FdEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NIXVhnzH;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ST010TGo;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69763606A337
	for <linux-hardening@vger.kernel.org>; Thu, 26 Nov 2026 09:36:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69763606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NIXVhnzH;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ST010TGo
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQ7B6Vq3548371
	for <linux-hardening@vger.kernel.org>; Thu, 26 Nov 2026 09:36:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	05HkMf4ygIqtlQzRN7ZbpqVF0GJOazAPdTl6j41Coks=; b=NIXVhnzHgu082yqW
	abalWNzDOxFZhGuNyI7ByVWj6XtldAX6FNnRjk1R3+UFYJawEMNoJZxSHvaHd1aa
	y/lylYTrMZMQPJjTH1xQ+WuXNYh//2rPDLR8TVy7nTNgJKN8EYGHFJGqkbjlrfk2
	HmbGJ+iFyZOW7sIfJzapKHmwx2uBeRjpcei/L75cvpnGBtL5uyde+1cjyB3jPOdu
	eUKoWKk2JIwfQBAocqIGMVU9nxYYTmjxMaD6TznCOscivByzNo+H4jWYMNLqqPN7
	xOuOVl859J0HizB7ni5LBcLUFJU99ngJ6vbqAZbaG8iD6rDY7wb+XX5lPB06zm2C
	iAOWXg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j62vauad0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Thu, 26 Nov 2026 09:36:27 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-920fb8b9859so46904816d6.2
        for <linux-hardening@vger.kernel.org>; Thu, 26 Nov 2026 01:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795685787; x=1796290587; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=05HkMf4ygIqtlQzRN7ZbpqVF0GJOazAPdTl6j41Coks=;
        b=ST010TGo+ikyU8MVhQ+E8UTzGE/wik/S2XrcLddBG8RjEstLlS2CZyHIZGj2yibcM2
         ALscMSpxy4X67sPA8ye+mzGp4uezDvhDuaFrGW0QwwIEIHd+sBRgSExorA9Uf39do83q
         yqipOSHlVjcnhiZHbZ0Qk4jCsT0Rn+VPaZHK7cECmPWiGT2/+iij1RrCCDf1Atb8Ycxw
         CE0M0zHHfJp/ZOJzR/pAqssIoZH0/aOzri5Y5/hCswZy5k/Yuize3H5h1864GOBkkLsE
         1HsZHPIqtBqKpZMUpym1NtHp+XZw4rJOtAgS27rCm3lHv5+I4uB50yJaJnypRuavwEAc
         IdBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795685787; x=1796290587;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=05HkMf4ygIqtlQzRN7ZbpqVF0GJOazAPdTl6j41Coks=;
        b=BEOAZQtYvKlsnebp8FJRMKTwHZutoZiNgU58td8q3OKYwBv8cjfMudLwn+tr25ixKg
         bSJimi96NTIURm0poVFGMF9oxYb1n9h2tBFI/Fn+fw2575Z2qATAdsrAj5XuCjZePxyG
         L0hq7J2I+T94VInd3T8+a06rAZpPehDq6ZeIL/MeISoPK921Gt+bg7KowlNgaG9tWyG0
         JGeZSPNhx0GE1I5lf4kJ5+PKQXx8GU3RNhEyeBMJ249ed/cg8EhI06vAKBacR6N/5hic
         f0tegXIRqoQIek3nQL7PIt9805wqjUU3ciU8NmEsRdPGs9xNiOqLy7Z0/j+S1OdK22jE
         Eb+g==
X-Forwarded-Encrypted: i=1; AL+hErGsVo7d10+5sPjNbJ1GqFe1aVQqw5YPgIfnbSCR5APhhNR904vGJ3lVHQ9j+p6ASvEvt+0fXARsuTxf5vSFSW8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/rmjHTKBjQXPjyn0M2sNMsc0xteIsyATS1/5+MvEtG8uzSeRkT
	x/GWqPsy667padLxuWzb0SY23KSs53nMZA5PMTJ7YgRwILltXaZVJK2l+EDhOlAYhVzh++QekrK
	WoGYm0mu4kmocOxV6Tloa0JRItBkqO0o7atlMYaA6YgwUMIkfe5LMRPnriRv1hfnI+XxrTqQ=
X-Gm-Gg: AZFdTZex+sqXPeSmaykKPneMgEpA+WZvSAwCg0HVBZNW7RSTL5VaSu/d0EUkQ085YIm
	/oJbH2YBVtN2ekYZV5aiYinr0iadtOBWDPVIShvkFJKq/rFEgU8Ln9Qb7oz/3CJWpcI6YcDy0PB
	NO6bz2tOKkBeckbSu0D+QJu+/513rwjIE1AtdjtChxExbJ0Dz4ppdFbhutXDRHWCuIxYHfNxAtu
	YuJQO1jqKuhPlIOYxmXax9Z70UWaIfqtWTrCPS2lw4GEMwi5iJunMzZOoNPxhjLVveUhI7fPoFA
	CSlbt26R1fi3b1CKX7+9apvbJthJqgOzfs4E41fi4NzEef+q2a7bUIQmb03Qc/UXhRHmLZcdn5A
	DYACB7LNmRZERFGQdM2Lw8sLMILEB8rPH+AXEhHr/XTooZHaCpXkAFvtJ24FTpFIt14RPJWs3Om
	BazA==
X-Received: by 2002:a05:620a:4446:b0:949:6574:f367 with SMTP id af79cd13be357-949bac8c5a9mr3645415085a.80.1795685786719;
        Thu, 26 Nov 2026 01:36:26 -0800 (PST)
X-Received: by 2002:a05:620a:4446:b0:949:6574:f367 with SMTP id af79cd13be357-949bac8c5a9mr3645411985a.80.1795685786268;
        Thu, 26 Nov 2026 01:36:26 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8960068fsm227079335e9.4.2026.11.26.01.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 01:36:25 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 10:36:18 +0100
Subject: [PATCH v4 01/10] lib: string_helpers: export and rename struct
 strarray
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-fwnode-for-each-prop-v4-1-d4b370ecfd52@oss.qualcomm.com>
References: <20261126-fwnode-for-each-prop-v4-0-d4b370ecfd52@oss.qualcomm.com>
In-Reply-To: <20261126-fwnode-for-each-prop-v4-0-d4b370ecfd52@oss.qualcomm.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>,
        Len Brown <lenb@kernel.org>, Rob Herring <robh@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>,
        Linus Walleij <linusw@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-acpi@vger.kernel.org, driver-core@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1964;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=hYScHpsRvvGBrMd1w71TLaQh4T+I7gIpjdQzKJBQdf0=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBrB/2Tb3bU70k5uNCHd9DHKLI7AbP4/lR/4ThiP
 pB9xbKGQFmJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCawf9kwAKCRAFnS7L/zaE
 w0vSEACwAuSF5pl297MCgnmYK8Yx/HwO0ljwt+t8ccc8bpUGvx2jbcf2rDjTxnwzOuGQX68E9qn
 AHKXALKHUnUZS/uTHsbtEhU9F4S4EW14tOCqA87Giz5SHfWhgTfgKgwZoViFwveppCrg8NZmrLY
 X/WsJ04SptxP1NSU2RJee1r9IORHFOzFZMJLDbselGbIQp/qk5QQqmfzeo6+Epv3jRtF1c6dyYp
 sb0mR9B5mFraz3sfOPjX1fzbtwfVXoV4+AEOZY1pJglVaDPxvtLVhCl/rhloqFmCo7z6wp2cCSA
 OmlIfaokYSWE33yxltAu10AB8MZDBB9xm180nqQ+jQbeWSuuiay3N2RCjjsANEmiGBXqiWbSPk6
 Z+wKVa7f5yXFf65X0gO9RJ5bruxLNC7hhoSRxKImvqL2d+GvB8YukI90AadieAdyl35efNJtkOE
 RzLBI/RjMhlmOXY0iATAPVuOVb+kqAPJEVDhn41vM5hGekJ8Eak6iKn/PY0DEPbEt3M+Sz65fdJ
 U52WP61v0Uju2OXgKK97CxaYlpQTqws7Ija56y57kW3rzcUith+JsHzNgFqx5UUc6nobuKdur1G
 2IdeHPUaNO+jU8QPeRKkaQjxMYJeM3JJzyXoZLaTkhl4F/QDiU9WgZqOovcvQVmvEu+fHY/Ne0x
 GakZ0caFYJxEevw==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDAzNyBTYWx0ZWRfX5U5OuZdUE3MR
 SyVApK924GdDBdBeCnK1wcpzC4Z+mtRo+Ve20UhLsjDEmtWX1N4ByqRKC/U3Xw2DjZhmuSuSfba
 wvPySB57VrsI0l1GXB5f8DOQy026nts=
X-Proofpoint-ORIG-GUID: tKcJfQTuHOFQqqCzrLns_T0N1wRh2dWH
X-Proofpoint-GUID: tKcJfQTuHOFQqqCzrLns_T0N1wRh2dWH
X-Authority-Analysis: v=2.4 cv=QZPzLcbv c=1 sm=1 tr=0 ts=6b07fd9b cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=QyXUC8HyAAAA:8
 a=EUspDBNiAAAA:8 a=NBg0Ud2t-6tr7aH_vnkA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDAzNyBTYWx0ZWRfXzGFPFtEBYWoy
 moczLPUrCLaq3jOR2zks79Pf1+9dxplvgvPy5fwm2MmE1W6pGGw+4BzVw6c0KeCiejKdmaCyjbw
 hnLmIOCQmpJz+LFGUTlgu9k8dzHEbOWdxqXj2grwEyFulBr8Vm0w+ZENQV7L1R9ShkNqKJfjzf2
 gts8zERqibVafGTs+3pQMMfXeo0gLzGFFkinKSgdOldlqZcrot7j84/3Y0huLZug/huXesZ6w4f
 hgXgcpRXr6L3Gtbt5QOKZXNK6L5X6UOcf6QujVqSw7pPmcBJDG+d9q8W9hlLFk8ueEo70K4eunC
 qA4h9Mbgwdmpbim9JtL7AGqG1RjAr4a22wJBEPnJyK3xvAtYPYF+MuC86FvegMoNIbKM0sPw4SN
 055cEeD+TPTdikIGgKhfm2btrTJN6CfIHrS+aHNfzKAdJ2cPsjeJjgBst1n874nYOUEnmYUMAQ0
 6QokoXXgL4VefjlgGQg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_02,2026-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 bulkscore=0 phishscore=0
 adultscore=0 malwarescore=0 impostorscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260037

Ahead of introducing a CLASS() for string arrays, make the existing
struct strarray public in linux/string_helpers.h. Rename it to kstrarray
to avoid any potential conflicts in the future and make it clear, it's a
kernel type.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 include/linux/string_helpers.h | 5 +++++
 lib/string_helpers.c           | 9 ++-------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/string_helpers.h b/include/linux/string_helpers.h
index 3fb88a1e989833ad5ea1a46858efa16e3971bf08..c9f08066439bdd33cc26e2054dbe1ba2e867aee7 100644
--- a/include/linux/string_helpers.h
+++ b/include/linux/string_helpers.h
@@ -116,6 +116,11 @@ char *kstrdup_quotable_file(struct file *file, gfp_t gfp);
 
 char *kstrdup_and_replace(const char *src, char old, char new, gfp_t gfp);
 
+struct kstrarray {
+	char **array __counted_by_ptr(n);
+	size_t n;
+};
+
 char **kasprintf_strarray(gfp_t gfp, const char *prefix, size_t n);
 void kfree_strarray(char **array, size_t n);
 
diff --git a/lib/string_helpers.c b/lib/string_helpers.c
index 98d6ed0eaab7e9f3d54e420c404629a28b925bf4..8ec7ff6dac1212fe8a1f242654944ba6e5568e20 100644
--- a/lib/string_helpers.c
+++ b/lib/string_helpers.c
@@ -804,21 +804,16 @@ void kfree_strarray(char **array, size_t n)
 }
 EXPORT_SYMBOL_GPL(kfree_strarray);
 
-struct strarray {
-	char **array __counted_by_ptr(n);
-	size_t n;
-};
-
 static void devm_kfree_strarray(struct device *dev, void *res)
 {
-	struct strarray *array = res;
+	struct kstrarray *array = res;
 
 	kfree_strarray(array->array, array->n);
 }
 
 char **devm_kasprintf_strarray(struct device *dev, const char *prefix, size_t n)
 {
-	struct strarray *ptr;
+	struct kstrarray *ptr;
 
 	ptr = devres_alloc(devm_kfree_strarray, sizeof(*ptr), GFP_KERNEL);
 	if (!ptr)

-- 
2.47.3

