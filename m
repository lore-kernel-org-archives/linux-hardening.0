Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795685798;
	b=5JqDMN+IirfE4/YoiNy7d6nM5lYuzjiVmmN8LxlAj4lfIefURhy3ybMpJcuSNRBjcQal
	 WMFtob3fCGsZdX4Y++l9D5Z5U2SKrn5CHvI3AG7OHkOofRxfTh3nZ7irE3vnY/nlN2Hch
	 U84G+G/7JwsFv8cKWllSdEO6o5I1zijeUs6Tqxm/vydbrI6WVgtt1gH5V6wIbKqZ6Il5r
	 sHu0RTIpEppT8iJN+UEcEgotSus6l+szfqDHlHQYDP4JKMsSaCItNBUiegJPDcJwcxuxR
	 XCkAg32L6FD0TxobbUfVnIEaCgY+DPMFuOPnjUf97WTTBTyR9kC36Yrs17ZgxVZX4UQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795685798;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=i7bRlwihZjUTsFP6PHnkL4XdT3UqstV3KfzOVciL9bE=;
	b=Srues7EnCXS0QVJy9gwp7W23tkVJDMN1WG4BE25EowNkVL7Ai5r8sXJLIsounOazRvxd
	 qOrg9dPl2SdKONcBPeS9tFbyspCa9ZFjZI2eFQeldnjRkoowpXllDj5bTcNHIUeP0cj2F
	 h0LtCT4U+AqYqKiy4R+SXyB1yzC8pTQpn+NBMCINSSd6RfkmuZRSutlxsjAuxqPkfnu5I
	 9Yjs05mIlkwU4Yh4zpSWMXYzpnjyaWgfSrGvFAxhJFmgKyGjQpzQBauw/60PnhpM4zDsf
	 oIBbqQc/I9YcM1xCgKX9l0obBZSNNSoK2+2cN9aMHch9iE8d/JsOhTnoDuH+0trA2lQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dfu8O+Tm;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WSc7dLJ6;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133E4606A6BF
	for <linux-hardening@vger.kernel.org>; Thu, 26 Nov 2026 09:36:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 133E4606A6BF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dfu8O+Tm;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WSc7dLJ6
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQ7B23R1682387
	for <linux-hardening@vger.kernel.org>; Thu, 26 Nov 2026 09:36:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	i7bRlwihZjUTsFP6PHnkL4XdT3UqstV3KfzOVciL9bE=; b=dfu8O+Tm9GHq5196
	a7d0SkHOprz6sE7d/GI/NOMA+Mjpu1FFCuLSd0/yzVEdky8u7rSCRdbAn6PGz4PL
	9GrtpdDeRXIwnS2nxYBeLbZv0ZkenvXeERvLcLKowPBGc0TqHqEPKcXNL+gsqBFU
	aXJz6jKNQU+uU6R+78FNEJtVW02vYQrLDuYKIKF1WRiOarMF3ymXek8hpDlu2TBH
	QycuUhiRaq4/j05W5jm8alOA2l/dw/wlffaRZpoYYpJ2yoNMusIMq0nc6HOunPMM
	BLoAJ2c2Tvj65xeyJE/XmURoOT2E7miqS34bQBtS4pLFk4TL33WPTntXOhM7eq8j
	dWm4LQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j62aekg42-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Thu, 26 Nov 2026 09:36:37 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-94961511b61so1096726885a.3
        for <linux-hardening@vger.kernel.org>; Thu, 26 Nov 2026 01:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795685796; x=1796290596; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i7bRlwihZjUTsFP6PHnkL4XdT3UqstV3KfzOVciL9bE=;
        b=WSc7dLJ6CL6SBQC5M+kj6n4bnKILnReyAINStvGuF3N7LsLN/LDtLiYMqCT1ACgAzr
         ATt3zfZw/a+lBjRfqYriHhXVHir00H4lWKcV3jsHIU1H5vo1cE2DLnz7lwmWG7tGk4/B
         NsDf7IBv7harZWpKvUpyDryo6sQpv81AnR7P6n4MhNvIOYatk9AyY7xNauAC5iR6B4hp
         L/btGNkkj5ygSG7kgo3SG5VV0rpU7c0cIWZX3ztOvh96BCBKWfXYy3bqjgjEQIBrvghr
         DhXSk3XwR6z7FHlhtieYYmDxkYsFz16T4ID6TaHVBtuWvwekqwwZ1UPLJo28pjmNQRcE
         au7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795685796; x=1796290596;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i7bRlwihZjUTsFP6PHnkL4XdT3UqstV3KfzOVciL9bE=;
        b=q4+fOmibwhYr5Mvw6taONzruYZUYn3VPjhE5rLTCzWL0tLrDbSO+lNdfGefGHkwAwo
         FTVCkNEhtaNxV0JuwlIyGGYcMqnI1jU1pV1EWzdmnmrRrpe+WMPtx2aZQc7rkKhoRlkD
         OqD6sqy3K+SQIh2z9vK0gusb84gwtwBTABIR8feICmj48uNthGuFN0vlBXbHhVlvMLdY
         b7MWtmeL73KnfDNAriQVzMt9fyxjuoRKE1bfdzSlxS7AmGQD0tKF3qCRDqZwS/hjNSyd
         KESRrktsIUPBfhsPw5l8OOYzem2X7PzTM3jhw3i5212mrXpGzqhF/WpHDNWQLcZGgu6Z
         Slew==
X-Forwarded-Encrypted: i=1; AL+hErHKdQJwKaShRLoPxZW/qoEcZH0/65tex5WY+Avj0eAX+gPNh1Xpm8EHMmYJdj5h0pXwCEqRMOe2wX3fj4z18HE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+bRu86yZa7V9A/rTPTi1k8cct22YhUvZBp172pZ9aqAPJQOsG9
	vz8hfqqhp+HHp2lzmb+v6+Yo2PS23xlr7kOgErb+toe5YoqkssbTOUbk3/ysFkMQa/nl87dN74D
	S3x8aL3otWxVh9DIreC1sW6RSl6/9NjFHKfqEpIgA5avzcbj+kuK4TQH0hfnSeIySJfwpugs=
X-Gm-Gg: AZFdTZc1m+1gYTyJ3nV5KKdn+3VtWO2FtxFyuXlGRlBXfZnhm3Xq/3gj76E+ycmYI1Z
	bA3ZmUmAjebMbEnTWeDYRHiOriBj9x6ewQXgn1tbG0d0y2eI54XRVU04Lh7D7/eNTFyzwBwyVPh
	U/F5Q7SLYr75MKth08H15AEA/svVSWvvLBHUmsYkRGX+8URd78+/rHVl+vZDG05kPjyS/LwxN0S
	SNJadNl1ZRQAi0zXjTqfGHN5l/gQSifN3t0E10p7DV3c3yr2ce2PIp2eCC8+x5xnYZLyzZ1LUEv
	sa4niFBVpw92Pr500AIeFm20RT156PAgY9dbQajEYIfEuWxE2mGPHvJSPXD4EqW056vVfiw2uOV
	vcglGQw37fKyBFRf+aK1e+q2tdpOFlNauIuPMGcWTQVlaeIQhYZ1DnBP0gsJ7nzV/iljVbGZ0AO
	z67w==
X-Received: by 2002:a05:620a:3915:b0:93f:21de:f3da with SMTP id af79cd13be357-949ba9555f3mr3146879385a.15.1795685796516;
        Thu, 26 Nov 2026 01:36:36 -0800 (PST)
X-Received: by 2002:a05:620a:3915:b0:93f:21de:f3da with SMTP id af79cd13be357-949ba9555f3mr3146874885a.15.1795685796052;
        Thu, 26 Nov 2026 01:36:36 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8960068fsm227079335e9.4.2026.11.26.01.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 01:36:34 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 10:36:22 +0100
Subject: [PATCH v4 05/10] of: property: implement the .property_get_names()
 fwnode operation
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
Message-Id: <20261126-fwnode-for-each-prop-v4-5-d4b370ecfd52@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2169;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=cY8stbRkz7FS1iwfnygR3+k+2ltIZm0psXD3WUEmssc=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBrB/2UO+lx01O0GqAWYuDsvg08MbU6QceNLg616
 XID7nnBbP6JAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCawf9lAAKCRAFnS7L/zaE
 wwatD/4kfdutYcUeg+BVG2axYBYlEgdVMCv+0Uzrpq7Cg9Bc0hKbZA37FbMw0YJqYYimMg2ckOV
 p05Lqi1rUbTLdIo4JyC0n+dEs492aPwD2rw9Md4ALEnQKrVClsjOI9kdum3pLyPn64vjEqt1uFp
 Ad+DXrD07tmyIqbMghSBB9eJT5F8YbV1SJDAhRKw0c3CBXaEOssFS7qg2Zzp0fNlPKwkV2qUCy5
 vmbMTkviVRBXN1G0YnPbOoQySAG/zPyp6uvSSzHLjDhA1MYszJJk1f5zmEjZs2dAowNUcUvN2Av
 NMPhbSg7XL5ajA4u56iFkGqwGpj8lG5Qi/zgslfWEmyFm5lQZJ9NjDlzmbnM+VZ7rpv8OYFVF8R
 dYXzUgR0yt63MMTM8uy9MXVYP317jrj49Oos9Z9BhJcK5Dxs3mc35TQyRU8t4ZyXs5wWN2Rsyg9
 w7/NjQlrtCMxoxeISs/w5QqWvRchfNyRf5HYSajuBtnsiMbpvJhCSGq0IM5EaSHV5ejs/PPnCbW
 XjL+Ic85RfxT+QG9qSR/xpjuI6zdkOT4DuSEjPzg71FuQ6/xf7rQx9OG88rJ+75Xdpnl8FERYns
 keFShgzyXMLu85XBHAiRHxsfeME90btahJg7Z4nStFp3vAl/vhrtvnDe70jzN385wLFsKX80sKt
 lOuwEaSEJ5E44og==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDAzNyBTYWx0ZWRfXxnRZoph7tRfL
 Szayb+UssKQiIokqgrmxI/AxIu6f+aEdTnoR5Q0X2eXiZcAoeqHR/De3ksY78vFJ/t0I9HSgT4z
 GPeN3suZCK+Ie5wN497MNBTGHWh0sKt/8rVmfDA68UniXTO5ppujO4d5aRl/uOwJyeiRGcsNyfa
 qMrs7z4f/10b8lRnorSuApVuRfQhk0s3nwcRRiSf7Wz34NxzwbOWoCSl68hmafYOxV0osarguSE
 J7+dM55nJALvXaVk9OyMIqPY03U83vBm5pDoB6fR/Vpqpk/yYMvoMBT0UT1l+OjLTYRxCUaHgfy
 OmasZwl7G2KPsxjGlvHRPpCZz6P5HxK/C9Eg3xIplRhZHHjNCq7XLtk13pcHMvJLShV1wzIq/EA
 iKfiGPBEIbhQ6irUlFaTI1fDrHPnqTcvN2+0hElsIOUVaMbKjfOyQNazt5MQU9JGpVqFPa/mCRO
 r8M9MV9K1w9lNSUgCwg==
X-Proofpoint-GUID: tZVhxgXebSCikrTesL-Li9eg3nk41lPJ
X-Proofpoint-ORIG-GUID: tZVhxgXebSCikrTesL-Li9eg3nk41lPJ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDAzNyBTYWx0ZWRfX23xMsW0QNQhn
 FDWb8EldhYzZ5Y9bM2lN6RzniYwT1+TVRr7lokse8rnUIyeIbxjV6Jusapy2QOEZcCFcED9tLNk
 UJUtnSDGjEEwO7JZIP9WL5+CsH4THpY=
X-Authority-Analysis: v=2.4 cv=PqoG/AM3 c=1 sm=1 tr=0 ts=6b07fda5 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=1UpOkSE8KFTI9Xdxe0QA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_02,2026-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260037

Implement the property_get_names() callback from the fwnode interface
for OF nodes.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/of/property.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 51db25cbcd4e8bb8c7066ce6223dee8a85e027f6..00349e78fa51455696d0b34ee02ae55c20cb23d6 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -27,7 +27,7 @@
 #include <linux/of_device.h>
 #include <linux/of_graph.h>
 #include <linux/of_irq.h>
-#include <linux/string.h>
+#include <linux/string_helpers.h>
 #include <linux/moduleparam.h>
 
 #include "of_private.h"
@@ -1120,6 +1120,37 @@ of_fwnode_property_read_string_array(const struct fwnode_handle *fwnode,
 		of_property_count_strings(node, propname);
 }
 
+static int of_fwnode_property_get_names(const struct fwnode_handle *fwnode,
+					char ***props)
+{
+	const struct device_node *node = to_of_node(fwnode);
+	struct property *prop;
+	int count = 0, i = 0;
+	char **names;
+
+	for_each_property_of_node(node, prop)
+		count++;
+
+	if (count == 0)
+		return 0;
+
+	names = kcalloc(count, sizeof(*names), GFP_KERNEL);
+	if (!names)
+		return -ENOMEM;
+
+	for_each_property_of_node(node, prop) {
+		names[i] = kstrdup(prop->name, GFP_KERNEL);
+		if (!names[i]) {
+			kfree_strarray(names, i);
+			return -ENOMEM;
+		}
+		i++;
+	}
+
+	*props = names;
+	return count;
+}
+
 static const char *of_fwnode_get_name(const struct fwnode_handle *fwnode)
 {
 	return kbasename(to_of_node(fwnode)->full_name);
@@ -1737,6 +1768,7 @@ const struct fwnode_operations of_fwnode_ops = {
 	.property_read_bool = of_fwnode_property_read_bool,
 	.property_read_int_array = of_fwnode_property_read_int_array,
 	.property_read_string_array = of_fwnode_property_read_string_array,
+	.property_get_names = of_fwnode_property_get_names,
 	.get_name = of_fwnode_get_name,
 	.get_name_prefix = of_fwnode_get_name_prefix,
 	.get_parent = of_fwnode_get_parent,

-- 
2.47.3

