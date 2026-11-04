Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793801057;
	b=U9lkbiYTuMdCnwOBcEQI7w6HGv8ELhpVig1n8gA3mQ7yDG9JI8fc5as00SsollqQlynX
	 zSSFcwfU7IGxgQcX+xxHT4NrdWF8ulqFTxLQNexmQ1AgWmrWbuvkwPlgr72O1aG6slgRP
	 t4k5W1yY2jOFbUE4GGFVc1bFZVTS3sPKjv9ikmqIZO7elctAX7Sp7+WtjO5z7Ktvj6TDY
	 jc9aCQSE8N/ak1CzBNrf1ghUe9DMmwVbt1UCxsbYa4rCBIp6sbxEEVxuo8Sz12CXNupv2
	 A4U6JM543UoXkxIDJVAtt5XSRyS7y4LK4fGNmDNinyQPXNilWr780q45UKQBrhNZ7Rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793801057;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=E1AqakhzVdc9Vv48h7Bt2KKLj8pj9gQLGMHQuyOjDKY=;
	b=KWJs+FH/z73cAg7iwJZMVW5qxeLNxmyZCi0EARX+ZMx63SucoMjc/ACwKMJH3wxTpeIK
	 /FYj5lHA25KNIpKu5GAwVCS0IPUfiWY+JMADdByJE6iH3+FJUzSBpC0Sth44TPQ4FCwWB
	 20vPnSsVFnnoSF1s4+nsN2M29gSnpZLN/C5JJcQTZueWz4M9rFgQU0t49UfeQ1PtWwScS
	 KIy+2W3crNQpAeKzqUZPZlGzN1WldX3TgyggkkunelBsRcXt1Yy+4fqi3Le5ajWvTMjf2
	 YNxHBRZ26IB9OC1Qcf+6Sog4W6vRdTRcyLL4Fvspfcn7gdCwOA4LOXO9jNsyNiM2/kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hW7tXMvC;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OJs4qf8C;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6301606A332
	for <linux-hardening@vger.kernel.org>; Wed,  4 Nov 2026 14:04:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6301606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hW7tXMvC;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OJs4qf8C
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A4BaFRm2729016
	for <linux-hardening@vger.kernel.org>; Wed, 4 Nov 2026 14:04:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	E1AqakhzVdc9Vv48h7Bt2KKLj8pj9gQLGMHQuyOjDKY=; b=hW7tXMvCQpuSSKtN
	ZFd63aatRREqxNb/XXFLE6kATLNEDiKcpvjMvAjmx39RMsGxDeRD5HsnP5epFx8i
	C7VX5AhR/CS7+Kz+Hc8bHQYjGtRDRzcKW0AJMtomtI04C6denBUTQlrW+cOE61g3
	wcFoo+1OtUxgc/Axpl6QascgzF2dWBsFgQCota6CxqKob/Xfr3m5lC3OG7Nzrq8X
	shy8CFc6gBQWyiQCU/8XeClybsI7Vc4YNFyP1eWoxBFkS7sfb7Abq7mUlfTd66lr
	j0MZJpxFrVVyvYsF5pOhzRxflj+eWAlkT4oLT0C/uLmh68Re2kCZr6Ma65mnPw4U
	ez8wLw==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqpuvbpgw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Wed, 04 Nov 2026 14:04:16 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-5ec3e1921ecso606982e0c.1
        for <linux-hardening@vger.kernel.org>; Wed, 04 Nov 2026 06:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793801055; x=1794405855; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E1AqakhzVdc9Vv48h7Bt2KKLj8pj9gQLGMHQuyOjDKY=;
        b=OJs4qf8C2UkhuuP7ZEbLVGpACKHKALOZhpMwx3Vyb1zRw2SkWVVIbzt7LfurMIJqb8
         IraYE5wPHd8K+DPdAAtovzrEoE53gLn7tWRSFrzITPewgAsV00P4wZCrTBiFNhAu99Cj
         IXM/0gWCVMSFie8fktM8l0pya1GHagLk4ktvx3G4eoqR8e/sXqbEtsy3rbWIkAPLYYjV
         8p++aQoITlIM+U/5mUiBLHIooBeBvvRyI8GfN81vFaCSQOYI9wEd1eOvQ1AoSxwl4ZDv
         TfRKsdDfNBDRmIFt4UhkeW+H5e7uCQ5A3pNmB9Xvw3w3A71UNc8E4fBroRw4002uPIe3
         3XaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793801055; x=1794405855;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E1AqakhzVdc9Vv48h7Bt2KKLj8pj9gQLGMHQuyOjDKY=;
        b=BWVonn83OxA+GuWY2XkuQou+3QEX3pqrxdJKoVuJdG9bbb30xG/Stekw4WPuBtvPne
         fYEOB9MH4baK6ywLZWOkbWVCLfmVu0KO27UE6QsT8vDgCkcDwMiBEVHC+wxKtyl5tn/w
         J292KJUFJUHjfg4etinoSyMid0bhrfE5JLZUgxtHFgBcmoU4gwioeGtAKXZR48CF/3su
         AecxqKTaiaA7pVfmo7cU2rpMaDKAAirCX4n+Fb0QvysxAGOu3aEybXHakfvhK1eST7Gg
         bN8Sko9VzPd1Y68zSsTccZQw58NUGKtHOb+w43wRJ6JF9GOarzKPZoMQWeRq9WYwDfIP
         G5LQ==
X-Forwarded-Encrypted: i=1; AKwUvBwYzP2IdhLfFeudpmgswyMr27zl/La8UUgBXtUZVtqnwS76PSWKJEYdExyipTHFgaW6G81ZGjq4p+gkR+W7Fh0=@vger.kernel.org
X-Gm-Message-State: APuU4Z8b5g8JIE34mhBmlmBaK8q1RTakq2hwaKmRKUFpFbur6nRmqZfV
	KvqpVbqMcIo5POI8ir/kHPjzCIzD5GpIX5SiXegQv7lCuQGnPtzakhDavhUEfm7udol0tXPCtFq
	dXpl2M9sBR68sW8xiDuokk7+vMCVD1lxPqowxKIqbt6EjFydP7srYtgphTUU1ZFIT8nKzA0s=
X-Gm-Gg: AYBFou12ZSkKiZ+wqDBczzDagrdTjUzVUyfRSke/lL+O+z0YwMWmo0nnCJZoIie6vGP
	KJ7hwUcCephRzPTcgRviF2tZamqdkZx4zYQA4qVXC2sF/p5Ebx8oAFBlX5usHOWSGMGCSMAdvHR
	260Cvm1H7cRBOGX0ay7hG5WM3zAM6Eg4ze0Nf+AQ0CJfuSQ3B3iUtsgCGG4MOilmC3s8DTdReVB
	vPaeedcOWHpM2DYpp3D/25Rh+lAQ8Z0TlywuGXitXn7hcRbUKVCFIoj4VnSIcpLtbl+phjgfCzj
	vqYC/wQIRuGtAMFvjt0FodN76wTE/AlliaGmhX/13Ul1U+73b/eBDdLv2NpEUAeQxdaRba1xyCU
	zSNXYnnuqkaJ8OxF6GST9wBDenLYEEW7EXizjwNm1OW4FPovmCtxE+PsrJTsxUWch80bxpyyfmU
	X53w==
X-Received: by 2002:a05:6122:c155:b0:5ea:ae80:c97c with SMTP id 71dfb90a1353d-5ec5879d16dmr4305620e0c.15.1793801055062;
        Wed, 04 Nov 2026 06:04:15 -0800 (PST)
X-Received: by 2002:a05:6122:c155:b0:5ea:ae80:c97c with SMTP id 71dfb90a1353d-5ec5879d16dmr4305566e0c.15.1793801054567;
        Wed, 04 Nov 2026 06:04:14 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fec8d87b5sm3968358f8f.11.2026.11.04.06.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 06:04:10 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Wed, 04 Nov 2026 15:03:44 +0100
Subject: [PATCH 2/9] lib: string_helpers: implement a CLASS() for string
 arrays
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
Message-Id: <20261104-fwnode-for-each-prop-v1-2-6e28fe1c72c4@oss.qualcomm.com>
References: <20261104-fwnode-for-each-prop-v1-0-6e28fe1c72c4@oss.qualcomm.com>
In-Reply-To: <20261104-fwnode-for-each-prop-v1-0-6e28fe1c72c4@oss.qualcomm.com>
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
        Linus Walleij <linusw@kernel.org>
Cc: linux-acpi@vger.kernel.org, driver-core@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1349;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=X4m+GBtBmyDIIU2ymTvn7JPXMmdv3wdDg2SwxtGCMic=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBq6ztSySWtk1BlVtDvFLGvG8VThjJrWy5dSYUhX
 +WkF61XXdeJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaus7UgAKCRAFnS7L/zaE
 w6+4D/4j7k8c1zrVHvsP7FPnP0L/Otl5Fq+MKofbzA4D0w0BETcvM58YVvJIHn0rRzBRYjXgFv0
 9qXudM0FtJwygIzyfZIzLte56iIzSHDvMIEkS4RdkjvSfn/EImsCZvUHuLS1FwGEHAY/L8mjvAZ
 7qADB4uj85+JnI3rgvVNZO30GttbJaZv7hUd/IgsvP4X+WqtexFh+HDOGUoca8rX+2K2RRlXDmB
 xXan6FU77l2TRtc+/356EJklrHHYMCS/bcWARKNjk9scpRFZY4j1z5ihdJBNcXdo5hZQfPu7iC2
 /92H9utwbeeMTc7+9VMLVIp5BTnmA+3t5Uy9tm1H0qA678k2SpLmAjHjIqTDEnvJcuTMZZzhECm
 3zQbX1fOX28Kk82WsaTU5j4Q8h74/YWhmpbsNgmOKrVhOoeDPKs4PqPqb168OwbQBGQ2/8cnefn
 lmQ/Hk111jcr4umGsCttNdWUsG7GaK9fzEnkisIUJAzZz1DFKUL76R/H8Ldg3V/6YsMf6Sho37w
 VJp5EAu7XJcDdQ1cyN29EDRHxXg5953KclxYnuuRSHcuJPQ7qUgmfwG1Fp8I/T1hbw5meMS7Uul
 RdJgx9RGQanZK2xKrKQ7BjUaUOAUmSHM596KQlL7gscczn/73v0KSu8d/plig2FW1xjmIPHujHp
 MVDUJD3sOPzk3cA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=O6SsLx9W c=1 sm=1 tr=0 ts=6aeb3b60 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=lR0QwHyGZrhmQDu0ocIA:9 a=QEXdDO2ut3YA:10 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-ORIG-GUID: nz9u7EyGSqpidW9RdKYo6GL7OIwa2S_7
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA1NSBTYWx0ZWRfXx7FDYA7/k4MS
 goF9lAH5K3IERH62Zf7MYlzPDZ0UwzPnD3LON4xzBUc5j3ufHye27cqL7uQtOisPg1TRyTiTRMY
 Z7d8EaGmmBdkem8yI8oQwNR/57Fd/rI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA1NSBTYWx0ZWRfXwPk6KDeBvFiO
 OYwSAC73kds/8OCnnJDKhNUjLQCnO+goAEGJcs88DmvdneLnU4k8HMpdSbWNSKCqkynIW5/ge+d
 Bbgw70lkX0eXrWov1dMEpXR2a9UtHoxE57XT5Pm1Gg4mQT3uCrZq39ycwDiR7N5fln13SIXTqoA
 CXpUtow74ZTDwUT3vUogLzOXyo2u2TLkQT+1ExxcDeYZLY8GDCoavcdAYMaQhspqRtxvvJdsH/Q
 mSVhGnuEIpGzn61kbG85q3vecFJUbpSlWkAY7gGpXe5VVuSqD/90YXRpt3IYoZN/V9QsECMU9bU
 1Cwv0mvNUK/JJksWJliXcJYtrG+RaEEMSlm18YxGYFkzNPyZKemZUOu6rAFfHNQO5GCjJ77/Wyn
 Q1hA7x/NuFsyIHqwzKBgPkYsI7MdbSC6yVdt/wom99ail7PqH2v/zbfsk4zdnIpkWSApEV4Qqa7
 ZAILbT9mSsUKj5yTwag==
X-Proofpoint-GUID: nz9u7EyGSqpidW9RdKYo6GL7OIwa2S_7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_04,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 clxscore=1015 spamscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040055

Provide a CLASS() for managed arrays of strings. It can be used for
automated release of temporary string arrays when they go out of scope.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 include/linux/string_helpers.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/string_helpers.h b/include/linux/string_helpers.h
index 3fb88a1e989833ad5ea1a46858efa16e3971bf08..3122be1359a36272190264d1c3e4c84dce785e6e 100644
--- a/include/linux/string_helpers.h
+++ b/include/linux/string_helpers.h
@@ -3,6 +3,7 @@
 #define _LINUX_STRING_HELPERS_H_
 
 #include <linux/bits.h>
+#include <linux/cleanup.h>
 #include <linux/ctype.h>
 #include <linux/string_choices.h>
 #include <linux/string.h>
@@ -119,6 +120,17 @@ char *kstrdup_and_replace(const char *src, char old, char new, gfp_t gfp);
 char **kasprintf_strarray(gfp_t gfp, const char *prefix, size_t n);
 void kfree_strarray(char **array, size_t n);
 
+struct kstrarray {
+	char **array;
+	size_t size;
+};
+
+DEFINE_CLASS(strarray,
+	     struct kstrarray,
+	     kfree_strarray(_T.array, _T.size),
+	     ((struct kstrarray){ .array = array, .size = size }),
+	     char **array, size_t size);
+
 char **devm_kasprintf_strarray(struct device *dev, const char *prefix, size_t n);
 
 #endif

-- 
2.47.3

