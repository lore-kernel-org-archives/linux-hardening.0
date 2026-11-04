Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793801085;
	b=RIOrpzvR8vFkm7GbLcfYZKp0EGaKy78mGweRwh7z6+I/xA5EcCPje8LoMmdQWFteKeLa
	 0X3vg79InnHZB1R9U+yETYmy/b3Jx3S5TtIy7318UpFYrXFq+Y9rdCtvyAtrObxG2wsnR
	 jC1evdt3BzFdl/WKl/L8dW7m9RD/DRJJf6wT/GB/APOq9eSCnR0ForYCbv5Qxu9x/KX+v
	 JkRrP62xbWvq/wwO8CNCTqyFVw3lqPbclrw7lxXo0VfcBVSkHSuzHxYJ8PFH4gNNxe0Fw
	 med657uvV8fZKHNvftsoYh2UkIWmj9WFwUUKVDrjyvCJP3+ZlGDn+macXmCWDXnYO5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793801085;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=CvpiuG2v7LqsgYioH9W2BL0A18x1i9O8dQ1j4rntT/0=;
	b=ExiIe/yex/ogt07MTNMyzk6Ciai31zUVjmY4FNYP8fBcdrF3oXCRTyzponDbGBC+Z9/p
	 m+rojAU0Akn1Q+8ap5+WqX99zi/Tz9xvBn8ojNWeB5QiyynOJWnvzPljEqXVABnKBrHyX
	 qip1vHpW5A6OS5AdtxKXUIT/HgIQEol8kU3OlXIsgeYfCqEsgWVM8Q7LBz9Re2W+C6sGz
	 8IspeES13ef4oRS+Pn9+yLZuyEH6XlhFe55CmiGu9HxhIxYBfeN0Tey7gN4RydsxnMhUl
	 M/Q3T3veaMJAsVvJnFaF2Vpgu5vmGi3vYHoB824Fp9t6ntfx57ZpjEVvhhUhukgD+qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=c5t4RPmy;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ezWqZaom;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624596082BDF
	for <linux-hardening@vger.kernel.org>; Wed,  4 Nov 2026 14:04:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 624596082BDF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=c5t4RPmy;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ezWqZaom
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A4BZtvh2667767
	for <linux-hardening@vger.kernel.org>; Wed, 4 Nov 2026 14:04:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CvpiuG2v7LqsgYioH9W2BL0A18x1i9O8dQ1j4rntT/0=; b=c5t4RPmysFcyTYBU
	gl3xLV5rm95mUnO2g888eol71FJq/lJnSkg+q27jKn6y1IrIH5wJ1XcVx+Ved10L
	VPr+KnEzZI/Zr0xU/Q3GzaWj2N7jM3HzhXoGWcg6XsPvsjFn/mHrYVJiR2tccSy1
	9jdXY7BHNogQPf6oFPXcMOReKGsUOlrnLVGgFhEeVHCtznJOJAcBNMR97EV51Dpf
	OBf/ZpgNdweXsCyXC+xxL2WT0lky8qI6cLbpmGeP3Jpv3M5iJAbTk3K4MhQJ/sZZ
	v9WPQRCZ3rYHYjv/2spmuT0H5P+XQSN3ic9Q1iZMTUBHqRiN97H/eoRZDeGOXP4s
	kLzJcA==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqm2pmegw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Wed, 04 Nov 2026 14:04:44 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-5eaad8219b0so52612e0c.3
        for <linux-hardening@vger.kernel.org>; Wed, 04 Nov 2026 06:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793801083; x=1794405883; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CvpiuG2v7LqsgYioH9W2BL0A18x1i9O8dQ1j4rntT/0=;
        b=ezWqZaomCipUIxZRKXnpY8uhf7IjnJFuEIOYxYzRoAEYHYeDhZA4buWShJCDhDojF5
         0Fg0KOER+KVzb8kPWH5bzhC3tqvjLqHNGCCdnulD8YZi/R2TDv19977Pp6rda9gyJF2t
         +FsOIvBNjLN1IlXMd/hqzl52Kn+67Q7c+kSmhPKlCnaKLW3BKz+Qly3oFbVgp4SUcAfe
         v5s04n1TpQErTFmLmJyxCwh+AI98kClCkkHjtP7kLilaRZ2kK7/sp75DHpuqmkdjaJqe
         qOjqM2TZ5pkROtqiUS1ujOHnhGas/6v6NZzIKXZ4jSgc00Xx9ZckJe7Yu3+QfHgxqQpW
         KjHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793801083; x=1794405883;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CvpiuG2v7LqsgYioH9W2BL0A18x1i9O8dQ1j4rntT/0=;
        b=Z6M5wIZnBmf7lFT1Cch/vWOEqBK12ogQcpQMmrdg6nmdNyMLhGO/qqunF/Wg3BYlF/
         vNhwVcfHwdvzqY+YqxUNXPRqj8Zv+X7Q1uuDKFzQhC51zhEpxCpKpexZOhsYXn5CffjM
         cCJTbEuPTr9PEG1fTJoCW+L05bt5g2+hCfRzb7vNduzRQV0i+hGGPVUz45LEx09Rxnlr
         B+2ddPE5F7iaSdsiRjNZrwkqiUz6V6n8CPOANkkqocgeAZCtgtauJHJwfhnlLK3CeOfl
         7Jjxya4iV6SKmVVLu1fhzaQEmiElN7KuWLEqmz2Bc4k7ObC0/1XzyaIk9VAJ4sYkbZxO
         HgZQ==
X-Forwarded-Encrypted: i=1; AKwUvBxRF6woy4qU7mUkCgdz17puWNnM0MNPGSFltlSyH3pZWTXfYjrxTK5Z0XdEPLarr9CApH29uVKEKvds1+3/XK8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8ixSEA3uc1u+ZcqrRdbKn6k9BohuqUCAIEeYfpjTsY5RXVxAPI
	B4XyF4eQM46AIOBP2suwwEUgIXNT8fXoukswKk949MViKexjHdjWxXEe5o67/DSr5An3FLs1j3N
	fABtvcSR+PdSIFsmgef2XrawHyugTqcqK7JGXVRE1pAYz/NF9qrP4LwR0TaO3Mvn4062hDBc=
X-Gm-Gg: AYBFou0rLXWfcnSyLbmQqDHR39WI3PzGwISpGrJZYpsxZUVVY8OYR/jLOyiGu4yPXdB
	Uik0kUbP59ERE1gNOeLZYTpwmY2Ixn7cMIfGzUXHk+s+l335u33LciHtX4qYQRusiZR3U6YIlwn
	f02jOM7qjg6gJ/IVaHm21JREBzkh/fJsve4QlR9kO1CKMWMlXql2zTx0tYcYJPI3Wj0ZxLgnlar
	jaO6dIadRNW8Ti7uJfac24MR/7Z4GW8U/qjf4ZWfdO0o1YbnxzVEVPgkEG3gSk9fJTwh/+rWYk9
	OSkRtRbvZqrEFe21ZP3AqMu1y5OwRA/ZW1n74XBOBk0ZLSD6yIBDVZ6SlcC3i741C9Zkr3uM9cY
	HwdvoQBdukrxHF2fXAK5JZpYtkkWQogfIwiCApPRXUbWf9lssIHf6nAkzPqQgR77RNqXkdhUPdG
	nrgw==
X-Received: by 2002:a05:6122:3c54:b0:5ea:c11b:432c with SMTP id 71dfb90a1353d-5ec68971961mr7027627e0c.15.1793801082501;
        Wed, 04 Nov 2026 06:04:42 -0800 (PST)
X-Received: by 2002:a05:6122:3c54:b0:5ea:c11b:432c with SMTP id 71dfb90a1353d-5ec68971961mr7027502e0c.15.1793801081438;
        Wed, 04 Nov 2026 06:04:41 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fec8d87b5sm3968358f8f.11.2026.11.04.06.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 06:04:39 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Wed, 04 Nov 2026 15:03:51 +0100
Subject: [PATCH 9/9] gpio: shared: generalize most code to firmware nodes
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
Message-Id: <20261104-fwnode-for-each-prop-v1-9-6e28fe1c72c4@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=10683;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=WAePSYcqwmx9zFDVEtTkMdht35rLwyfSp8xtwHJeP9A=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBq6ztTe/ygpY5Gk49WKX0BfmDIFYf0/pLuvhnEn
 bpip+H0OCKJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaus7UwAKCRAFnS7L/zaE
 w1d2EACOyKpj5dhBJMlbVVapisSgNcGsb4M7PItzp/Lx9O7KynE4un8oyXXsZBuFyLWSC8lP+yV
 I/tysH+DWRbKEmIuMgCxjZVRWURerYG5oPKtmlnal2D6JF+exsSkm0++B+wu1SLMlicRS0oaAta
 MIMd0krCpM3V3DV1ucIE/hQ8QgV48uKx3dfJQ+/byirds98knrhqFq5wUeNyvLzyPF21TuGAyYv
 JKtPh+Mv+aZfPc7pp93EurC0VA7C2ziPqPdBl5rjrX8rHS+wWTnKravvLXsHEPvmvsYuFnr6Zwn
 zD7OK07UB+gXKSRqQO8te1pnQsYg9ny20ozpzdGUSvw2nBFlDz8oBW3OSLAxxcJhYAlBwfKT2QV
 LSqpbHtxmU8t5atIp55nrLV4O+jF+cLB+zydST+v5xsMAQ3qfVTVhFVkNPQbd2UCoOd6/DdEW00
 iTOiPgQuYoWtWcYnev5tmQwZfpuKP0hWYBcNecvfAM/xqV6XfC/yLx4JX6tTxvJNHhO23tvfmw6
 +U4F9ofABssgmBf5L8q1AbcGkKG+/kxgs11ZNY1AyW3gSYJqxHIFpPLP0gMRF3T20O6aG2P5yPp
 7lPrjHWWLmHw9FkEGzmMwB6clhkpiKyfcwTtMzfZ0tFpb+bw34caFXqYMrXS7wBY4NthrPvUB0Y
 RUEyG2TYSTqRmmw==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA1NSBTYWx0ZWRfX+Sz6KfulGqPG
 LqUySXDm3aTHQkqnjlFYngarKFOt5UF/JF3uZLY4iVLrKMwPf3FVOtNxSCgU1MkNWWwEE3+X49t
 1rVbaABnJexKXJ4tPsD5Zv77dsvDxP9D+zel8h0lnPK8OrJsE9OaullwvmNdBLibZcA7ur+F5ao
 kHoomNS6yDScj59VXZYn2OuGm7KIK/J4y2oQr0qgg6V53+FtpoeczVfMTf5M5J64LRdynIl/cek
 Asn5jFzVUius4PRmRYN88JAwUNyug25Zmnrp5q1u4R31WHR3xUF/zAsUa2svxeo29nbm2DHNnLM
 ZvEfQu0zyzOndHFJc4nAaUeKiH0tuRmdOqSf7GU19I+zOE2PaGg0dKeA82fh4y+Q7cccRIqq27k
 y9LMIQnqTWQNQp2khC709DYFO3Z0s/WQkAiEzcYWYicqcWJgKhABOkp3x6c1eCS73I+S4F/PoSV
 udFPTEH4BOrqL35UP9A==
X-Proofpoint-GUID: 0FkGwh-cvwUbLXs25I9TwJEOLChoi3Cl
X-Proofpoint-ORIG-GUID: 0FkGwh-cvwUbLXs25I9TwJEOLChoi3Cl
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA1NSBTYWx0ZWRfX5WMM2uXQPmn8
 7XP+Jmh+w5tzrJCeMigt52TVZF4DIxReasrKj49ZZDphQDzNCoTzHyv5iX5p6R4UIldgfAoWyrU
 14EyinBoG6gMxdTrrMAzFIIS4Fq0/dU=
X-Authority-Analysis: v=2.4 cv=c64+0h9l c=1 sm=1 tr=0 ts=6aeb3b7c cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=ziVQ5hnd3nnfPSIR4FkA:9 a=QEXdDO2ut3YA:10 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_04,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611040055

Ahead of adding support for sharing of GPIOs for other types of firmware
nodes, convert as much code in gpiolib-shared.c as possible to using
fwnode APIs and guard the remaining OF-specific bits with CONFIG_OF
guards.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/gpio/gpiolib-shared.c | 241 +++++++++++++++++++++++-------------------
 1 file changed, 131 insertions(+), 110 deletions(-)

diff --git a/drivers/gpio/gpiolib-shared.c b/drivers/gpio/gpiolib-shared.c
index 8c9ac9d9330490b17fb3936b8758beb97a308a15..58ac049bb603e2946c81e67a047b4788d39213b4 100644
--- a/drivers/gpio/gpiolib-shared.c
+++ b/drivers/gpio/gpiolib-shared.c
@@ -23,6 +23,7 @@
 #include <linux/property.h>
 #include <linux/slab.h>
 #include <linux/string.h>
+#include <linux/string_helpers.h>
 
 #include "gpiolib.h"
 #include "gpiolib-shared.h"
@@ -63,7 +64,7 @@ struct gpio_shared_entry {
 static LIST_HEAD(gpio_shared_list);
 static DEFINE_IDA(gpio_shared_ida);
 
-#if IS_ENABLED(CONFIG_OF)
+
 static struct gpio_shared_entry *
 gpio_shared_find_entry(struct fwnode_handle *controller_node,
 		       unsigned int offset)
@@ -133,158 +134,162 @@ static int gpio_shared_setup_reset_proxy(struct gpio_shared_entry *entry,
 }
 
 /* Handle all special nodes that we should ignore. */
-static bool gpio_shared_of_node_ignore(struct device_node *node)
+static bool gpio_shared_fwnode_ignore(struct fwnode_handle *fwnode)
 {
 	/* Ignore disabled devices. */
-	if (!of_device_is_available(node))
+	if (!fwnode_device_is_available(fwnode))
 		return true;
 
 	/*
-	 * __symbols__ is a special, internal node and should not be considered
-	 * when scanning for shared GPIOs.
+	 * On OF-systems __symbols__ is a special, internal node and should not
+	 * be considered when scanning for shared GPIOs.
 	 */
-	if (of_node_name_eq(node, "__symbols__"))
+	if (fwnode_name_eq(fwnode, "__symbols__"))
 		return true;
 
 	/*
 	 * GPIO hogs have a "gpios" property which is not a phandle and can't
 	 * possibly refer to a shared GPIO.
 	 */
-	if (of_property_present(node, "gpio-hog"))
+	if (fwnode_property_present(fwnode, "gpio-hog"))
 		return true;
 
 	return false;
 }
 
-static int gpio_shared_of_traverse(struct device_node *curr)
+static int gpio_shared_fwnode_scan_property(struct fwnode_handle *curr,
+					    const char *propname)
 {
+	struct fwnode_reference_args args;
 	struct gpio_shared_entry *entry;
 	size_t con_id_len, suffix_len;
 	struct fwnode_handle *fwnode;
-	struct of_phandle_args args;
 	struct gpio_shared_ref *ref;
-	struct property *prop;
 	unsigned int offset;
 	const char *suffix;
-	int ret, count, i;
+	int ret, i, count;
 
-	if (gpio_shared_of_node_ignore(curr))
+	/*
+	 * The standard name for a GPIO property is "foo-gpios"
+	 * or "foo-gpio". Some bindings also use "gpios" or "gpio".
+	 * There are some legacy device-trees which have a different
+	 * naming convention and for which we have rename quirks in
+	 * place in gpiolib-of.c. I don't think any of them require
+	 * support for shared GPIOs so for now let's just ignore
+	 * them. We can always just export the quirk list and
+	 * iterate over it here.
+	 */
+	if (!strends(propname, "-gpios") && !strends(propname, "-gpio") &&
+	    strcmp(propname, "gpios") != 0 && strcmp(propname, "gpio") != 0)
 		return 0;
 
-	for_each_property_of_node(curr, prop) {
-		/*
-		 * The standard name for a GPIO property is "foo-gpios"
-		 * or "foo-gpio". Some bindings also use "gpios" or "gpio".
-		 * There are some legacy device-trees which have a different
-		 * naming convention and for which we have rename quirks in
-		 * place in gpiolib-of.c. I don't think any of them require
-		 * support for shared GPIOs so for now let's just ignore
-		 * them. We can always just export the quirk list and
-		 * iterate over it here.
-		 */
-		if (!strends(prop->name, "-gpios") &&
-		    !strends(prop->name, "-gpio") &&
-		    strcmp(prop->name, "gpios") != 0 &&
-		    strcmp(prop->name, "gpio") != 0)
-			continue;
-
-		count = of_count_phandle_with_args(curr, prop->name,
-						   "#gpio-cells");
-		if (count <= 0)
-			continue;
+	count = fwnode_property_count_references(curr, propname, "#gpio-cells");
+	if (count <= 0)
+		return 0;
 
-		for (i = 0; i < count; i++) {
-			struct device_node *np __free(device_node) = NULL;
-			char *con_id __free(kfree) = NULL;
+	for (i = 0; i < count; i++) {
+		struct fwnode_handle *ctrl __free(fwnode_handle) = NULL;
+		char *con_id __free(kfree) = NULL;
 
-			ret = of_parse_phandle_with_args(curr, prop->name,
-							 "#gpio-cells", i,
+		ret = fwnode_property_get_reference_args(curr, propname,
+							 "#gpio-cells", 0, i,
 							 &args);
-			if (ret)
-				continue;
+		if (ret)
+			continue;
 
-			np = args.np;
+		ctrl = args.fwnode;
 
-			if (!of_property_present(np, "gpio-controller"))
-				continue;
+		if (!fwnode_property_present(ctrl, "gpio-controller"))
+			continue;
 
-			/*
-			 * We support 1, 2 and 3 cell GPIO bindings in the
-			 * kernel currently. There's only one old MIPS dts that
-			 * has a one-cell binding but there's no associated
-			 * consumer so it may as well be an error. There don't
-			 * seem to be any 3-cell users of non-exclusive GPIOs,
-			 * so we can skip this as well. Let's occupy ourselves
-			 * with the predominant 2-cell binding with the first
-			 * cell indicating the hardware offset of the GPIO and
-			 * the second defining the GPIO flags of the request.
-			 */
-			if (args.args_count != 2)
-				continue;
+		/*
+		 * We support 1, 2 and 3 cell GPIO bindings in the
+		 * kernel currently. There's only one old MIPS dts that
+		 * has a one-cell binding but there's no associated
+		 * consumer so it may as well be an error. There don't
+		 * seem to be any 3-cell users of non-exclusive GPIOs,
+		 * so we can skip this as well. Let's occupy ourselves
+		 * with the predominant 2-cell binding with the first
+		 * cell indicating the hardware offset of the GPIO and
+		 * the second defining the GPIO flags of the request.
+		 */
+		if (args.nargs != 2)
+			continue;
 
-			fwnode = of_fwnode_handle(args.np);
-			offset = args.args[0];
+		fwnode = ctrl;
+		offset = args.args[0];
 
-			entry = gpio_shared_find_entry(fwnode, offset);
-			if (!entry) {
-				entry = kzalloc_obj(*entry);
-				if (!entry)
-					return -ENOMEM;
+		entry = gpio_shared_find_entry(fwnode, offset);
+		if (!entry) {
+			entry = kzalloc_obj(*entry);
+			if (!entry)
+				return -ENOMEM;
 
-				entry->fwnode = fwnode_handle_get(fwnode);
-				entry->offset = offset;
-				entry->index = count;
-				INIT_LIST_HEAD(&entry->refs);
-				mutex_init(&entry->lock);
+			entry->fwnode = fwnode_handle_get(fwnode);
+			entry->offset = offset;
+			entry->index = count;
+			INIT_LIST_HEAD(&entry->refs);
+			mutex_init(&entry->lock);
 
-				list_add_tail(&entry->list, &gpio_shared_list);
-			}
+			list_add_tail(&entry->list, &gpio_shared_list);
+		}
 
-			if (strends(prop->name, "gpios"))
-				suffix = "-gpios";
-			else if (strends(prop->name, "gpio"))
-				suffix = "-gpio";
-			else
-				suffix = NULL;
-			if (!suffix)
-				continue;
+		if (strends(propname, "gpios"))
+			suffix = "-gpios";
+		else if (strends(propname, "gpio"))
+			suffix = "-gpio";
+		else
+			suffix = NULL;
+		if (!suffix)
+			continue;
 
-			/* We only set con_id if there's actually one. */
-			if (strcmp(prop->name, "gpios") && strcmp(prop->name, "gpio")) {
-				con_id = kstrdup(prop->name, GFP_KERNEL);
-				if (!con_id)
-					return -ENOMEM;
+		/* We only set con_id if there's actually one. */
+		if (strcmp(propname, "gpios") && strcmp(propname, "gpio")) {
+			con_id = kstrdup(propname, GFP_KERNEL);
+			if (!con_id)
+				return -ENOMEM;
 
-				con_id_len = strlen(con_id);
-				suffix_len = strlen(suffix);
+			con_id_len = strlen(con_id);
+			suffix_len = strlen(suffix);
 
-				con_id[con_id_len - suffix_len] = '\0';
-			}
+			con_id[con_id_len - suffix_len] = '\0';
+		}
 
-			struct fwnode_handle *curr_fwnode =
-				fwnode_handle_get(of_fwnode_handle(curr));
-			ref = gpio_shared_make_ref(curr_fwnode, con_id, args.args[1]);
-			if (!ref) {
-				fwnode_handle_put(curr_fwnode);
-				return -ENOMEM;
-			}
+		ref = gpio_shared_make_ref(fwnode_handle_get(curr), con_id, args.args[1]);
+		if (!ref) {
+			fwnode_handle_put(curr);
+			return -ENOMEM;
+		}
 
-			if (!list_empty(&entry->refs))
-				pr_debug("GPIO %u at %s is shared by multiple firmware nodes\n",
-					 entry->offset, fwnode_get_name(entry->fwnode));
+		if (!list_empty(&entry->refs))
+			pr_debug("GPIO %u at %s is shared by multiple firmware nodes\n",
+				 entry->offset, fwnode_get_name(entry->fwnode));
 
-			list_add_tail(&ref->list, &entry->refs);
+		list_add_tail(&ref->list, &entry->refs);
 
-			if (strcmp(prop->name, "reset-gpios") == 0) {
-				ret = gpio_shared_setup_reset_proxy(entry, args.args[1]);
-				if (ret)
-					return ret;
-			}
+		if (strcmp(propname, "reset-gpios") == 0) {
+			ret = gpio_shared_setup_reset_proxy(entry, args.args[1]);
+			if (ret)
+				return ret;
 		}
 	}
 
-	for_each_child_of_node_scoped(curr, child) {
-		ret = gpio_shared_of_traverse(child);
+	return 0;
+}
+
+static int gpio_shared_fwnode_scan_properties(struct fwnode_handle *curr)
+{
+	char **props;
+	int ret, i;
+
+	ret = fwnode_property_get_names(curr, &props);
+	if (ret <= 0)
+		return ret;
+
+	CLASS(strarray, names)(props, ret);
+
+	for (i = 0; i < names.size; i++) {
+		ret = gpio_shared_fwnode_scan_property(curr, names.array[i]);
 		if (ret)
 			return ret;
 	}
@@ -292,19 +297,35 @@ static int gpio_shared_of_traverse(struct device_node *curr)
 	return 0;
 }
 
-static int gpio_shared_of_scan(void)
+static int gpio_shared_fwnode_traverse(struct fwnode_handle *curr)
 {
-	if (of_root)
-		return gpio_shared_of_traverse(of_root);
+	int ret;
+
+	if (gpio_shared_fwnode_ignore(curr))
+		return 0;
+
+	ret = gpio_shared_fwnode_scan_properties(curr);
+	if (ret)
+		return ret;
+
+	fwnode_for_each_child_node_scoped(curr, child) {
+		ret = gpio_shared_fwnode_traverse(child);
+		if (ret)
+			return ret;
+	}
 
 	return 0;
 }
-#else
+
 static int gpio_shared_of_scan(void)
 {
+#if IS_ENABLED(CONFIG_OF)
+	if (of_root)
+		return gpio_shared_fwnode_traverse(of_fwnode_handle(of_root));
+#endif
+
 	return 0;
 }
-#endif /* CONFIG_OF */
 
 static void gpio_shared_adev_release(struct device *dev)
 {

-- 
2.47.3

