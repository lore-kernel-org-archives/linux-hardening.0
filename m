Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795685795;
	b=ClUSV2/Y9+1EDlqe2uoiLUwsyEOlcEDuiMwBHrqLtvatR+kUpbt4Jm/wLdS90fAnb8DD
	 LB266j5oCLaq4OnsQ3fh9pW3sifQR14LO1FUQRMDvd7xjUtw2upjlE+TU4snKQ/++hG43
	 26MDgry46MxVDS7I6rfejn1hw7sgTDaomgtadDB6SY1D8u37jNYADiUOXXc/2pnCk6PCd
	 3OkcCPVckdAy+oKPK+8mkPA6zgmV+CdcHahqgEvojgVbG6cHYDM9nbAhCt5nXnCiNzPUy
	 euZE5v7ouRQ93Vp8VNQonf5C0am8KBMAlNBdDYJzlOBnkHilvHB+q1c6FwakvopZbtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795685795;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=miMzlMuBpxJY0ZOJ0YqAM8Lp2tavdioHkHezErAmbps=;
	b=0gCOiO6jSU/cUtyxJP15Z8bexEFiCUavPR4IXdmKL2hzlAcpuEFw/q4tprdH/wMPWBlc
	 2/p6pRcpvt42CVhoJmaxUtfimsOnqV9Ove5whulljXInMMxW+MQSg84RrOrrFC2WOe604
	 u+dXBHjNmOHluu22FH1v0UHg3kKOzyGs2iZF9G7mjzvwqJrlRSkuieG6jvl3MwwnpqMTM
	 mtp7NqPZFIoHkeQ3FuvdVPJ1tj9TDGn0/9ytXeNE19dDA2mRnCAJB76JxOOBGu5W0Ul+v
	 k3Wz43Obb85XF80RXB/bxdzbRuym8gPPHzVPMtgT/riBt/2E6ItRUSvYD6ixa+82UgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=IAp92qRC;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FvJjSmvw;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07D7606A68E
	for <linux-hardening@vger.kernel.org>; Thu, 26 Nov 2026 09:36:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F07D7606A68E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=IAp92qRC;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FvJjSmvw
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQ7AvYT2594855
	for <linux-hardening@vger.kernel.org>; Thu, 26 Nov 2026 09:36:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	miMzlMuBpxJY0ZOJ0YqAM8Lp2tavdioHkHezErAmbps=; b=IAp92qRC6qZl8kUw
	dH2qKoQmKk9Ad0X2uXjBsxvj7BW98KbGXr26eM8tcJEOIXugphWV7Ln/tOHEOaQR
	lqpjFh2NVdRV/l3dXbSmQl27jsfXDr+jY1hv9AZ4uSbQm1vSdZZnyP7druC36Fsb
	8MjHIrGBAlGaABrHzQOQryiOob3K93lZyzzDBFNYG/wIuFFtnqnH1him/5evqPm7
	o2A3K1wHTMUI+9zfIsU7CMN0IE4Q5Gu4cmx+W8axXAK3Xpjdv9WfC+ghiXt8EAge
	CfgAXyMdWNvSwFax3OWCU8mfYocl+yrnsgfS5lRBjn7uAwQdyXs+M3s1cmgJv4LQ
	8fB4ig==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j662sag7s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Thu, 26 Nov 2026 09:36:34 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-94961511b61so1096722585a.3
        for <linux-hardening@vger.kernel.org>; Thu, 26 Nov 2026 01:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795685793; x=1796290593; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=miMzlMuBpxJY0ZOJ0YqAM8Lp2tavdioHkHezErAmbps=;
        b=FvJjSmvwk5HbfmSrVSAwdxmF8sO5qsQ4rWfs+kExVGE1jWrJJWITkpnXwHklM4RS8s
         fhussS99wTgDTmnaZ/ckZAlHAiduDGO91SVGM9A8X7a/epqhUzU+Xo8TXvBqUEwbGP4T
         fdAeHdpaF3PDwrfXJGXydup0wsbJFIS2n6BiRpcPkTD65IX1KtxjKJanjSUtPJ1bxqRx
         HtcNvk/FcrGgPBs6x4elV3BhyRYrha7iqhJlHKgy2JeGELgT4hvdD/yas9eMlAmywF3T
         J5E5mb3iVlIqkFDvv1RxaltqDUZ08Ucoh1vhyFG35T11/VBWxVti8VrYYKC5Fe02XhMQ
         Sllw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795685793; x=1796290593;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=miMzlMuBpxJY0ZOJ0YqAM8Lp2tavdioHkHezErAmbps=;
        b=Zpx/fnq7v4f0cQpA1tUbRZBtHYCQNfEsitQFsTX6iOb8dEL2m/JR7d7CwRqFsQe7sX
         tDslGgshre2QLY12XQW+EwyKzlJ2D4VwW6DD+dvWkSgF2ZzwhLpy6xtywk4Y14v/OVq2
         GwLour9KGpncSOjU8xge2L+6FgiTSva4ZChCAdLGyPKM17GtAAu+fP9Scj2YXzJNycKI
         dNUqRnDinZWWyK0WNzaNTCg7EbYbniDHJbtYO8CjgGlamc7d2SZzQWQDh/zoHDjU/VNh
         fli0ECnQdDJ6HH+pheiVconzRnschrQ0iLKB3ke+NjwweHl6E5bgFCTXsyr7Gskiy9LL
         An0g==
X-Forwarded-Encrypted: i=1; AL+hErFB2kT0/fobRtonGFN7EjQ3ocUCtSnLqKeNZi7cgJzRPEEj1s7cb+8WbGJ4PEnfIyCUQt7bPK+N9tSuOKbPaKs=@vger.kernel.org
X-Gm-Message-State: APuU4Z+1In11+nQXy3eEAXdLFl/I2IjPdTQGwlnEY8vyaC+gLxEVnwIC
	nY6Iju5vTjx0rz2ReserZAljxEpbZivFJEIcVi37XyHWVjEHb8fV1G0iOjLEmO1KyhGB9fhGZkK
	5+Fhn6qFjHt3RtDzzKNycU2T8R9Ua7TW0f4Zh4082T3QQ2FYi//MZIvQozUPYSFUjqB2Uzfo=
X-Gm-Gg: AZFdTZdH3HL4wTlIICmV/tub7THzZoxzoFqj8DnNiZ6vhVcQLBMoHahNP0tPCw4wsaZ
	Za+WDfnAbICCTU5YKL5OxhU7jOF7r169u7bu17VlMp32/3BMfMDMQBRpWI0DBhgCj2P/6Obxm1w
	x8YT0K1zENirSS4LDO1g5gGBxPCH1P6KbDUNaAKcwnDFIY47FsH6/Sn+/ZZuPeyZ7/230LD9gSh
	jTDg/MsQ8CQMgMloo/7g/Cg01nCU8Q4moYkW7cIA5WCKs5iJDuDZ+Gsdmwi50yAyiy3nDF8eyix
	qXmRE0rn/04VZfNYKWdGvHt9eRPInBuf5tqhDaRfHXo9J8fWYOqVG+wj18hjjIDA4f+KnZUEmLa
	3SshqsGdjUop8wWr1dXme2nstDlN1KojkgOe/ibYiEH4ny3waIkuHKqbD/0F1fz0cw4DZNsD36U
	MBDw==
X-Received: by 2002:a05:620a:4386:b0:949:ba11:9612 with SMTP id af79cd13be357-949bab0cc38mr3252449985a.69.1795685793273;
        Thu, 26 Nov 2026 01:36:33 -0800 (PST)
X-Received: by 2002:a05:620a:4386:b0:949:ba11:9612 with SMTP id af79cd13be357-949bab0cc38mr3252445185a.69.1795685792680;
        Thu, 26 Nov 2026 01:36:32 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8960068fsm227079335e9.4.2026.11.26.01.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 01:36:31 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 10:36:21 +0100
Subject: [PATCH v4 04/10] device property: provide
 fwnode_property_get_names()
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
Message-Id: <20261126-fwnode-for-each-prop-v4-4-d4b370ecfd52@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4357;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=ssHUbGJUv/2LRpy7w8mqQGXezqPHplT3SIfG/I3JPWk=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBrB/2UFL2eWa1ZnlPyXIe+eu3NDH2BDtxgindkM
 qle2Zcf7BGJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCawf9lAAKCRAFnS7L/zaE
 w8ruEACK/zZo1BDYPo1sgvFBUDw5zsXDSNiM7OCb+9Vg9ICw5+sNdKHjQUYKn/VjG8DU8N8iYzw
 vsVuP0rttxGsPtjK68aEchLxrTrHU4EPawQoU4UZXvxHgNRQCRbHBeKimuyTq++AdjVwMSfX3dZ
 RguXIHFAOZtVo3HMTh1YXrcABHFzIg7ZY/OJyeI0knTMUxuNEeCgWYpBwfPVTplcQoJLWahh0fo
 7sGucCydGHn7bq6It6uLVEbvJvVZKRINvao/KdooCUPFW6MrCg5dH3nfjVwM23h4pdcB3LkSeqf
 kAjrIGQ8q/Fe8jZZk/R2D/T8cOQ+CS/ZbEN9EGiCrYR6FN2myVFeM3Nvz36qH6gbGDSwIsLWFXK
 ufWZxvT6pc+CwU+ZBEg30Ix5euq+Q1lYf2iMLiZwMJo2TQ0Ff+t9Nx+K39DM/cwKRw6Is6MhDiC
 dqd44UK1vTceSfivfDmmJi8Vw2E4NbSiHTNn2uRWThcfN3In50A9ODo7ac5odnntiEGt1CbYM4U
 CxNlDnkgUHhFFZC2yYoztJ+q2uGf4dbNiAU9NCstbSOgafCtvEq4krlif9J1n7iUjq7RmnNjXem
 lcIZX9LokgGTjQ8QzNpwWaTWIQSg64LRxSu59pZfP3MnG0D0QIaMBJ801V1j9VefT68eJqi/VcB
 jY8cFOAF4y851tg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=B54sQ+tM c=1 sm=1 tr=0 ts=6b07fda2 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=kmiii08LN68srmAI8Z0A:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: wsHiZEdlPUD8C9kWzc-yOePtcXH-eTqF
X-Proofpoint-ORIG-GUID: wsHiZEdlPUD8C9kWzc-yOePtcXH-eTqF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDAzNyBTYWx0ZWRfX9P8zIioG4YrE
 qi1vijj90p/zSP4Y+TwQpKnWpuhSexN7NOIC3/F398E/hYwLteszjFwFsrFI5+UYzdYNj8V6Afx
 E33toatSPNapnqrHK2raQ4jH0jLBNdPKzd3v7vKs9aAWrBmpjzMw9hHccvLyR43luYSiBMfdvci
 8lKrqsxS6dJfv2p83Vn1p4u+J74falR0kjKDuHH2HUMo7BGj798xcxceRHDHTeJkKkxttlVUa4n
 jNfj48EnQzmOFSB/7D+VxoEpoizedGNYu61xhkbwC6tsyydip0WKtvqfM6Dy/IXUqWiP7s620/y
 KPU/RIeQhlMfvQsZp8rPw2KKjVuKh4ZyO+2hV4HFPcLsqE/VUbJHk+9sHysIgv7ciSqgn2E2lFA
 GBnQoBi7xkMF7Kq6Zg+oXlDodruxHg9Xzh+ntzUuLSoR8jjPbbM0PrT2cfW7FQF+j/lgqM5D1VF
 NalPNK1xK6b+M8R+2QA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDAzNyBTYWx0ZWRfX07205/bpbB7n
 mFxTBg/Kyp4U45iRZ9BVnCbIeBVpiSegETaGCIfUCKSnQ4aRnqZ5KCPldLOs5e8aFhDxMiC0oiu
 FvX6/eSLWUaGv8pFcxpxIpfN9n6vmIM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_02,2026-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 clxscore=1015 malwarescore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260037

Provide fwnode_property_get_names() - a new fwnode function that allows
callers to retrieve the list of all properties of given firmware node.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/base/property.c  | 80 +++++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/property.h |  1 +
 2 files changed, 80 insertions(+), 1 deletion(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 7728116e296872b7ea4d4475aee72d95edf63eb6..d3c54c3d11c42ba4aef68687fc27291c7f33beb6 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -11,11 +11,13 @@
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/export.h>
+#include <linux/minmax.h>
 #include <linux/of.h>
+#include <linux/overflow.h>
 #include <linux/property.h>
 #include <linux/phy.h>
 #include <linux/slab.h>
-#include <linux/string.h>
+#include <linux/string_helpers.h>
 #include <linux/types.h>
 
 struct fwnode_handle *__dev_fwnode(struct device *dev)
@@ -542,6 +544,82 @@ int fwnode_property_match_string(const struct fwnode_handle *fwnode,
 }
 EXPORT_SYMBOL_GPL(fwnode_property_match_string);
 
+/**
+ * fwnode_property_get_names - get the list of all properties of this fwnode
+ * @fwnode: Firmware node to get the list of properties for
+ * @props: Pointer to an array of strings. It will contain the address of the
+ *	   string list containing the property names. Must not be NULL.
+ *
+ * The list also includes the properties of the secondary firmware node, if
+ * any. Properties present in both nodes are listed once with the ones from the
+ * primary node taking precedence.
+ *
+ * Return: Number of property names written into *props. If > 0, the caller must
+ *	   free the array with kfree_strarray(). If the node contains no
+ *	   properties or an error occurred, *props is left untouched.
+ *	   %-EINVAL if arguments are not valid
+ *	   %-ENXIO if no suitable firmware interface is present
+ *	   %-ENOMEM if memory allocation failed
+ */
+int fwnode_property_get_names(const struct fwnode_handle *fwnode, char ***props)
+{
+	int ret1, ret2 = -ENXIO, n1, n2, i, j, count;
+	char **prim = NULL, **sec = NULL, **merged;
+
+	if (IS_ERR_OR_NULL(fwnode) || !props)
+		return -EINVAL;
+
+	ret1 = fwnode_call_int_op(fwnode, property_get_names, &prim);
+	if (!IS_ERR_OR_NULL(fwnode->secondary))
+		ret2 = fwnode_call_int_op(fwnode->secondary, property_get_names, &sec);
+
+	if (ret1 == -ENXIO && ret2 == -ENXIO)
+		return -ENXIO;
+
+	n1 = max(ret1, 0);
+	n2 = max(ret2, 0);
+
+	CLASS(strarray, prim_props)(prim, n1);
+	CLASS(strarray, sec_props)(sec, n2);
+
+	if (ret1 < 0 && ret1 != -ENXIO)
+		return ret1;
+
+	if (ret2 < 0 && ret2 != -ENXIO)
+		return ret2;
+
+	if (n1 == 0 && n2 == 0)
+		return 0;
+
+	merged = kcalloc(size_add(n1, n2), sizeof(*merged), GFP_KERNEL);
+	if (!merged)
+		return -ENOMEM;
+
+	/* The strings are now owned by merged, only free the container. */
+	for (i = 0; i < n1; i++) {
+		merged[i] = prim_props.array[i];
+		prim_props.array[i] = NULL;
+	}
+	count = n1;
+
+	/* Properties from the primary node take precedence. */
+	for (i = 0; i < n2; i++) {
+		for (j = 0; j < n1; j++) {
+			if (!strcmp(merged[j], sec_props.array[i]))
+				break;
+		}
+
+		if (j >= n1) {
+			merged[count++] = sec_props.array[i];
+			sec_props.array[i] = NULL;
+		}
+	}
+
+	*props = merged;
+	return count;
+}
+EXPORT_SYMBOL_GPL(fwnode_property_get_names);
+
 /**
  * fwnode_property_match_property_string - find a property string value in an array and return index
  * @fwnode: Firmware node to get the property of
diff --git a/include/linux/property.h b/include/linux/property.h
index 9143fe4f5c05179e595ba875aafbcb006a740824..a70f3c4c087dd85390951da950c3632f89c6cfd1 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -77,6 +77,7 @@ int fwnode_property_read_string(const struct fwnode_handle *fwnode,
 				const char *propname, const char **val);
 int fwnode_property_match_string(const struct fwnode_handle *fwnode,
 				 const char *propname, const char *string);
+int fwnode_property_get_names(const struct fwnode_handle *fwnode, char ***props);
 
 bool fwnode_device_is_available(const struct fwnode_handle *fwnode);
 

-- 
2.47.3

