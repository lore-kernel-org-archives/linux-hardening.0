Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794584836;
	b=sdeX9O4u1blC0Z6c08l91pNzsZqjNJZfIRXiKNdxpZCODhxlNKqiBx8zK+VDwXa+nEId
	 7O4Cj/I40t5cw+wELfKsmqkpErY4n55dJ7xt6simy17EDqJH4wPvUrgiF5rpcVnGe6zRB
	 5SAhTMUyYtEcbkYgYHBWotEgxnHrFlyGelE8TZpvum7fZ09180+knfrswY1LWwAXUc40E
	 vFMhbdOtyr9x08UZ9St4GqsqTCgQu/JPFDM0+oTf+Qe31omQxn5ndBukDWyuyYT6kZCg2
	 4dlPHWcShUh3M8AIJPBLMVubeZORokPUeznPweqEQvAqqZfTb7xaeZMjIEXm4rnJRnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794584836;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Wed/p4dMAXGXPlOgd+Od6fs1ryzDmeVuvcuAAb2oZD8=;
	b=l3l+iK7dxJKRJ89wNT5Apgx2rzHIicjSUbEZBEhDJYBrtEmma2FbKVgNQh/g624+Q1hK
	 tl0RnHksr4EWXNkgpkALepxM8AFSNM9bYK/8eLnWTuKTyHIHFIw/e5N2W34Vncj6VuOjk
	 RrgYbWqwfZvrPH1Mus9C/iUpXVDFDIywvTsQmShlh/sNMGd6h1YFizso9DIyCQxr59mFZ
	 +kEOPzSUsTn3r4n2gB0/+YE/G4iK7/m+gSvttHlLPgXiYQ/vDkB50XDGRMwOH7DmLO6ci
	 TMv7qVYp+kDG8M3J6LyQb+tlw1pWdQwxJIC+1Enf6b88HdStXrAUzytyG7l3P+zswcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=n4egnpxz;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IStitQ2T;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2B3606A331
	for <linux-hardening@vger.kernel.org>; Fri, 13 Nov 2026 15:47:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB2B3606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=n4egnpxz;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IStitQ2T
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADFRS2m3296060
	for <linux-hardening@vger.kernel.org>; Fri, 13 Nov 2026 15:47:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Wed/p4dMAXGXPlOgd+Od6fs1ryzDmeVuvcuAAb2oZD8=; b=n4egnpxzMUjory/A
	EgpxLjmcnRjo/g0HqrZ3k1+S5ZhHMOrlwl1c6HX4lCY/+KurbdpSkhK0VSO7c82O
	le9ef+plrlRoqB8I719JVmeRxofV1IOQSyTsDzV2YBcwuYkwdpYfMMr4mDCjAj7M
	lvRG/lHlfk6udEk0GcftmLxA7lkn0T4nMDk0tkU4LsuNFC5nOk4+Ml60bpjAKyFL
	ZJGeQieIm4ne4VwBjti0xnBkT7HgO++agHVH1l8x0v4y/6cVpH54nME+W/hJV7/K
	MLc+EcMoN0Kz4umnQV2cokbUc2TUCyEOdSX1J8eUU25ZY1jsIhnPQWqO/pyGX7+X
	R+XxAw==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwvu6t0mv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Fri, 13 Nov 2026 15:47:14 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-7d2e2cd9c85so1007509137.0
        for <linux-hardening@vger.kernel.org>; Fri, 13 Nov 2026 07:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794584831; x=1795189631; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Wed/p4dMAXGXPlOgd+Od6fs1ryzDmeVuvcuAAb2oZD8=;
        b=IStitQ2TlnbGRbMsuaUy0bSmAbsl3uGIZMXp9N8mU3PcUWmHAUZHQ+SCapFjWmzAB7
         NO3MZLctan6xAyxOT5+R+EmSDDMqcH17rNDYXsJm+/abgBvzWUD5cHWjDnhJa4eeF6as
         PxuxehHp0pC4zMPifbyfg7zPmLGsU/hC+ZzLkMybhZcrRJCvsHU6PEHg52esZHJc0eu3
         fob9pzMwd06uJUmaWJzQ4+Pma2w+oRIM7f0nX5cjPIYgzNjRDGrWjhAc+Ac+GHdKNEqv
         uETW/Su5gZYjO2nNOchJrAYDDr0cjkiVq+AANP3wkxVFL/ULHxS61HVz6jECbvnn7aPR
         AnaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794584831; x=1795189631;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Wed/p4dMAXGXPlOgd+Od6fs1ryzDmeVuvcuAAb2oZD8=;
        b=m558pHdGDIpbbpRsvVMlShquIG/IGUg/H4XpmXnp0HTolOrdMiTYWb/fP/HGSFWqO9
         OpP/Eg0Hr/0Ba6Rw4xpgsNqLZBkI9ZytAUnPmQ8V/at0x2zFUWV9UPvDEimIOlTzz6PE
         qyZyIrlcWzp7FuvhMAsGBLJJQtWXT7EsSSxhEZixcKWE2A51DqV0KeCyapzZNGzQmDbD
         mnOGDSBHQetcNXY780HCl+KJY55KrbvQprntbRcPthtDs/ZmH7vAp4X7HTn8XxHXtvlC
         gQPHlGgySLrtdwRbv57zgWaO2XmY5OFo3+jvSlpDu+/Ftjk4qRPJlvVjRnCkqgDs28Ky
         WY9Q==
X-Forwarded-Encrypted: i=1; AL+hErE2YD3ZguTC3oqQBtXk870aguvlky0ThjcWD//T9da6lfl2A5nhxlCkFwq7V3dPZKQdhT0PvqH2vtivssqJK18=@vger.kernel.org
X-Gm-Message-State: APuU4Z9X284tf6f8GhkHwrecUnztRDOjbI/P94upKWzWPz7PU5Vp3QBM
	oxz/zybjPG3gYWM7sVm7reLdh4RtjnF1Y9/G5VQx6z6lH+bcSOPPrxyOzCPo4JsTuYO27I00Hbd
	0JysmiLFToeIguiQuMuLmS/nijrljqxZjAlYybZbKILLW8VmvlK2jt5priRRfTwNcjpoSAak=
X-Gm-Gg: AYBFou1RS/Btv4kLgIyG2jaHP+fSzEUdYqXvTihtNZZTW9+mKOwu+I55S5Lu0eqfG0Q
	27jRQkI9igs8lMFpvxXqLClseWvePXxnG4vhN12MgqCfNn5rF73XGYauyWeYyxUUUCo5y9odOXY
	hQ0Fftv6F7fqsT+OsqVhP1AyyggOCZnKkmb//5ZWJCUQkRol2jk7Ly5lzBxLXHXrbwX95nOwMzn
	GjCJqUe9hstM+Q1zjtQCdKKAXMLKdILQJ+D4NTcQpn0MRsKxLKFtTu8ZXb9hPifsL644Z7JYRBV
	qUf71WQGtMThce7mJo4bQmMTMHtxrvRYwGzIemo1TojF/shewLZVB5Cz32qVxjBVDPVHU9olU5j
	RNUYIp/jI7At8+AgHJ1hyJYKhGI8srIFBxT3mg7QgIkCQNA70AAKuemCm7QSN770Fu+1LwURjcr
	PKUw==
X-Received: by 2002:a05:6102:c94:b0:7d2:cbb5:71fe with SMTP id ada2fe7eead31-7d64d8bc684mr1050071137.29.1794584831339;
        Fri, 13 Nov 2026 07:47:11 -0800 (PST)
X-Received: by 2002:a05:6102:c94:b0:7d2:cbb5:71fe with SMTP id ada2fe7eead31-7d64d8bc684mr1050056137.29.1794584830870;
        Fri, 13 Nov 2026 07:47:10 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5f5972a7sm5636519f8f.21.2026.11.13.07.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 07:47:10 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Fri, 13 Nov 2026 16:47:02 +0100
Subject: [PATCH v2 02/10] lib: string_helpers: implement a CLASS() for
 string arrays
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
Message-Id: <20261113-fwnode-for-each-prop-v2-2-4edc23d5cf50@oss.qualcomm.com>
References: <20261113-fwnode-for-each-prop-v2-0-4edc23d5cf50@oss.qualcomm.com>
In-Reply-To: <20261113-fwnode-for-each-prop-v2-0-4edc23d5cf50@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1218;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=t30FPQpb4Tnh5cjxh+syE/bSfLdlIjxN8NWgVucIhbk=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBq9zD3zxDfNmTZ1oYpGu3oDNSKeYhLlJcTGJy3w
 i9b5ljY2i6JAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCavcw9wAKCRAFnS7L/zaE
 wzyeD/9liUwDxOgRuCtILa7ZmLSZouUUEBMZOFZYeJfLbxqPj5BOO3LrGyZBB4eot1x51iaTeaL
 seAk8C1sdvB1kdjX6QVoJ0tGLj3Ws44IQ2wvoebYW9lUY6deKsomvMU6U17LDKO3L/XaMt3FDjV
 e6/HReOyU8IGPJLMZdufybX2gEVS+Xi/MPiHXevqmFcPKSwOoRFNfchRO8E4tIOUoEJb4mIRsQB
 0rsnTeD1IDzbiN+9o8sigSIZVxc7md3ox8EmjUHcINHaClSoizGKJ5TEKAEW42pw0xIgalLcI/B
 Ta9vfewgPI6i03x3Bf99tJUk+JJ/arujVKmdsdTxAe1iIPmdsl8VIfL2upL5GNduYQ5LxyQRP0R
 wLCEUqksltK4bnonaZfrLbsYBG/jMOWQVFyDN5lARrMSAUS8set0dHoSVQRsG0HnuQymrmjVteg
 zDr9BzfXp7bdlYHJRThjawEDJTtrr3tqtNaBw9IHETOLc55+W5EbKbDdkCm9uib+NWXiiKN04kZ
 11miOyx0tXie3POOHvpLjdqe3gvgfBX6bMxZM7yAGpfgwWV66EHdGZMIXgHyKMg+vVC4m9mKL8k
 RoYXaq/lvXSIRKxVnv8lbV8T4AeSEaWmxBot0jOg9YtsPA/2tV6pyP2JS/lri4VVTt05v3Cpxld
 d+rv30AlQOrl1xg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA2MiBTYWx0ZWRfX5/Eo+fSxwSwQ
 4J0WPuR1O4TRw9A5obTy6I4s/p/xIvhdn5GiyrkZcCPJdF9vr2/RBMN1aptEdjHMAn8tQblZeVM
 l0EmczhQ63NltCAumEXPADew35zs967Vxo2QL/OaPUJd+mIzIwn+XcbUWSqeIUxls3ZFO43tTgL
 8EP2JGfNwbeULCI3v4/vFNVaozMScaL4XCIbbT/j+5pt+QpkqaWm7lrOKiRQqk4ZvPUYCiccJ3a
 LHvX7NlQRvg/JvjkbCmxZHPYLAB3Nkr2rDnqKI6T6U3jQHCPFOWE0V60Rn+45f+pvbNL3YSnds1
 4m4HXm1NmZnXEWlGhmbNHkydU6xoa+Vhgcj80Ayqq/1BmqVBx3PbShdrkyt2CgYTVK5Te2VobTw
 ib2l0HV9Ehn0yDd7g6UKcNJNPYF0nAS4VJ8i7iVezukk2t2oavuwoO2rGKPQbGtC7xfwMByf6Nd
 aG9HYAgWcogocslU81w==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA2MiBTYWx0ZWRfX9vZZNuU7UzJ8
 S+Qv/gY6ov389Zj0Or6lwfbwlnnmPSP68GPybj9hr+BIeVxaw4brHDNCiTQ4UB37lxyI2NvM/Ro
 CM27OUskCEIjJdSZCfXOapivOxqru5w=
X-Proofpoint-GUID: knGQB-qXOtiy_OPzmZ8BhDISnh7xkxZV
X-Proofpoint-ORIG-GUID: knGQB-qXOtiy_OPzmZ8BhDISnh7xkxZV
X-Authority-Analysis: v=2.4 cv=JfcpPkKV c=1 sm=1 tr=0 ts=6af73102 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=lR0QwHyGZrhmQDu0ocIA:9 a=QEXdDO2ut3YA:10 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130062

Provide a CLASS() for managed arrays of strings. It can be used for
automated release of temporary string arrays when they go out of scope.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 include/linux/string_helpers.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/string_helpers.h b/include/linux/string_helpers.h
index c9f08066439bdd33cc26e2054dbe1ba2e867aee7..4db73bc7d4623cf45954cc8794c5baff6fb23241 100644
--- a/include/linux/string_helpers.h
+++ b/include/linux/string_helpers.h
@@ -3,6 +3,7 @@
 #define _LINUX_STRING_HELPERS_H_
 
 #include <linux/bits.h>
+#include <linux/cleanup.h>
 #include <linux/ctype.h>
 #include <linux/string_choices.h>
 #include <linux/string.h>
@@ -124,6 +125,12 @@ struct kstrarray {
 char **kasprintf_strarray(gfp_t gfp, const char *prefix, size_t n);
 void kfree_strarray(char **array, size_t n);
 
+DEFINE_CLASS(strarray,
+	     struct kstrarray,
+	     kfree_strarray(_T.array, _T.n),
+	     ((struct kstrarray){ .array = array, .n = size }),
+	     char **array, size_t size);
+
 char **devm_kasprintf_strarray(struct device *dev, const char *prefix, size_t n);
 
 #endif

-- 
2.47.3

