Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795178825;
	b=Pz17fU+8hXtwY2TdSk5/2ARbQxZNaoOf0WUHtrR8bjXtd1uCCNBB684nZoYXlwiQzQPl
	 qpxrSnM5m34nw/JzwEniI942dWtcxiM6oiTjjXljmIdFH+PVJ//Voo1fDRP+prmyS8Z29
	 T2OgwSZdK3zx+Qjs7DKrUh0JQPALHOfuH4J5Qd1nu5LBSAzuRU2Wtss/rU3l/OooooKdb
	 mc8g6Rn/HDarbQs/E/wB4xdgf6FxJtxyhiIrWao6gcAPXeXeO2ew+8QYt7IY9JW/BHO5y
	 wNrfwWBLBpfBmJWttnY/NGnmtWckgk4/xYsLEx7wjhSmd3I/H/llwSMx7trcTHUG7Cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795178825;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=VW9PgIUqddV2ctIph8GklJCXOd/Fbs2bPwpKZj/erTw=;
	b=1uRVeMVZbm6oouhPd+d9Ls0PQmWc7hnIcwW+YTIqTI1iekYDtGetmHmgDVuvQEHSa+lQ
	 pj01qXvMKHd7k3Pyz3Lbw/QlsmvdVZ64zT9XDqqr9ZaCGJdl5iHhSVjyGAqeVNbulzPL7
	 oT4U2yO9KxYQQejFq/Zpsw4Ma98MR3xzn6rhD1awCiQv5uZzMuAnA7/msvQUz/fpGoCMd
	 1PQuqAdNKbKJWZOuxanoSJMIMpzG0MXf8PmhO1aBW6DAj8Nr7OEXH6f10/gzlBYqyectE
	 9twiY9kpITITlqIhjaq9bSoEBZPEsbdFxFQyMIDyNHUvLzfOnmFAhhdph9mqjlOfCjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ko+ched7;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IgcpA2Zs;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E4C60A263B
	for <linux-hardening@vger.kernel.org>; Fri, 20 Nov 2026 12:47:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0E4C60A263B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ko+ched7;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IgcpA2Zs
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AKBobqW1203420
	for <linux-hardening@vger.kernel.org>; Fri, 20 Nov 2026 12:47:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VW9PgIUqddV2ctIph8GklJCXOd/Fbs2bPwpKZj/erTw=; b=ko+ched7bFDddz4F
	j8dhA+j429hqyz2yk5Ncmi5aAa3rgLQEWYbkwqZ2RN8VZovqVe/lh1VS4yaINoO4
	wQkSsHZOVJDkSGMiPEqNIZfepjZpra8nb5wETHry4dTe453aseWRXnQAuWxMOGA4
	4S8u27zNH1TTH0ZUt0OFWOWOnzE5RXqk5O1vEvUOdcNTAk6+s1nVhDFyn9j4Iwhh
	XvCUYN66Nm0Gm7nPM7q+uHW5hAmus9Zq8Wd2P7KAGxExFUjwNDUYan2klSNHEgY0
	xs8b0U3v0dkuh7JxhRSD/S9BgD8Wp8JOJ1oyUQOLTO3sz5EtAWYNCdD98T8YGE9U
	kJWByA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j27fykr05-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Fri, 20 Nov 2026 12:47:03 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-94960131befso151271785a.0
        for <linux-hardening@vger.kernel.org>; Fri, 20 Nov 2026 04:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795178823; x=1795783623; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VW9PgIUqddV2ctIph8GklJCXOd/Fbs2bPwpKZj/erTw=;
        b=IgcpA2ZsZqpVSl7v6IyVW84NU2m59ch+2cnf597njxpkDny5cVH+v0ejy9ieyN1jrd
         Abm80g/1vvp0JmB0dojOKhnsaqMQpY8mTkSnaZ49B+NDC6EQp/gnHPxPvnQOcAl703Ys
         t4rDl0VsdNgZEJ5lAY+xFrcAHMLtMN0pdIqhVKECsP/+k07rSJ1jxrcOeYWWEo4lXsrb
         aj1Zlj+J2qZWPj8B6k3cFgbEWKJHgvLaf3LQIyPdw/XcFunfKL+LnxsLRTCVnWQj65au
         IA97aK9K0nV6bD8hVi4nmyKiWXqtCUdgu3/0l5EP3uEJoIoyO/e9CQ3Pij1OZSJnvYBu
         R/uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795178823; x=1795783623;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VW9PgIUqddV2ctIph8GklJCXOd/Fbs2bPwpKZj/erTw=;
        b=mPAZ0hqIO1mUUjuMtBrQvaC48fyxJnDrMrG1XC/dH+gnrZnV2fzpdvIssWCGUeROzp
         3T0xs/J45+8/gJ1aJcahlOXuj6S15Pj5v82YBy1jGNOvrXtlwjRBgNmqOebg9oUbGvf5
         bXjH1riIX90PRvDtgmOFM/2fnDi7EeHZ4LI3+jNlmr9pMIvfv+yT8aX4ZvKOFlZF+x2j
         JJRJSRs+Zbu1JkTK7VmrwkNAIabNK2K2sWxhvHLmPMXAvaRWZo9Gxq4kF3JudGYrIiY5
         xrC4rxjb37r3D+7C3jgiTE3lSzMgFbffeUVVLQdShmzikx3xg/wmFu8OcOEePRJm2YYw
         d2Rg==
X-Forwarded-Encrypted: i=1; AL+hErFfsPV+xRQy5SLvRErvxahWqeqa+09g0Fjm57Uz7Vqb+v6Cn8EMsOxZcJNR3l4uDnhPDBWtW7XnBpcxUZ8rDiQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z83MM+PtseQy6ETbK0zr6r9YOiOH/YFNYwtznziUZ1Hwlv90buA
	yUuJGnZImRhutdso8zHx++W5ZCEQKYqvWfsGP80/BDDOSQ5Co4v6RZqV0rvfxDYOECZOYL+qvt7
	4ZAXbIT8B7nlyrrhEUZGWMksC/J6qCYnOtwV06ZtCxVm1+qQdSE+D5uvkBWgY1RrSHAQN73M=
X-Gm-Gg: AYBFou3sZkC+nLR1nxtJp2OKJ8MBwfWli/m8e2RzmfkJtBNATgRwvGxP0FAXt/Cm9IV
	/z2bLorC/NrwbBMrtL7imJaLtQkLdSuj4KnCPsZMiPUYt47W7L5BotzCHhN0I94gD2Y9cLiflDT
	Mmv3mMrugk3wc5fyOhsZUsRxQCJ6Y6mnifx0jEQmyRqiEKpyt96fG63APQxQcKts3jjqf9X0/sC
	2fRjhN9NWqYC07WRNptGtXE/VZXlvzGze0Ye42YmeKplkJk5fVIaF7l2mxyc98FSBGmngCeVPao
	fPAvAeWeqEusm7kfOjoN5AW8OevwyLIaHJPOfStDu4oAh5lq00haYeoXUXaBgrMEIrhbbGyWzvS
	hhb6YORCnzOsF+0ZFgIL1nGBp1PSUCqGyfJS8QdjTz70OiBZ9z1LsQHVOWxkBeEoTt/ZjuC5f6y
	Q=
X-Received: by 2002:a05:620a:1307:b0:93f:1e3c:4a3d with SMTP id af79cd13be357-949ba9db70bmr444309485a.46.1795178823120;
        Fri, 20 Nov 2026 04:47:03 -0800 (PST)
X-Received: by 2002:a05:620a:1307:b0:93f:1e3c:4a3d with SMTP id af79cd13be357-949ba9db70bmr444305585a.46.1795178822702;
        Fri, 20 Nov 2026 04:47:02 -0800 (PST)
Received: from brgl-qcom.local ([195.50.164.66])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884ab091sm119248995e9.11.2026.11.20.04.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 04:47:01 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Fri, 20 Nov 2026 13:46:42 +0100
Subject: [PATCH v3 05/10] of: property: implement the .property_get_names()
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
Message-Id: <20261120-fwnode-for-each-prop-v3-5-808e304dc73e@oss.qualcomm.com>
References: <20261120-fwnode-for-each-prop-v3-0-808e304dc73e@oss.qualcomm.com>
In-Reply-To: <20261120-fwnode-for-each-prop-v3-0-808e304dc73e@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2119;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=k44LD99l6+yuoAWvft0Vpp5Uhsi3XgcWFZVnUcvzOe0=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBrAEE3jVJ3t+7uOpkpf/ma2oevHqicDxvGj6rBl
 oPQT0dmTv+JAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCawBBNwAKCRAFnS7L/zaE
 wztCD/9paaR0X5QgLZYpSkhTLDTDj+2CoshL76CwZ1C/euxfx9tQSoQJ4gzXzbBkFkBFqsUxlyt
 GNNSODrG5PYw8EjJ7vDMp48Ttka9c9OQKOoe3eWtu+G68YsiZI3GE2aBE8b8YaKFdP/w4/S0BcG
 /PVGqrbKQT06pLdEEM9gLJnwgcDz4HmRK5DUYeBZzn7VNiC/SXFpkvwYodJ7WDrkHJAfiJj06fV
 qel4dEHCkt61LsEDdkukVtcgBmcKQbGJDMcwPke2dFdp2ap6cL2vHro+W4tWug2vb8+wNXgPbRF
 mr00uwwasIhDyZgV3eH0lUPQQIzT2v0wixQdqAXuavckz4zkemVQbMDjlwo+I/sncQobi6IdmhR
 ux+nVqVmwREhNaSHZVR+WMQMIRowp5vY1azSPvpQweYKZBmjulfqby81nbNdvEVfrQqyi/Zu+EG
 XSyc3pusKBiDGRWdWDENGtbgMsqcUyHI6KEKY1iC1QbhZdmf4OGtDuoKT+uTSALX0IOM0P+/Dmh
 Ty/QCv14O/KHiziP6X2ihEiRIhDjSVJJyO0vu7PgCORHsL+/4NcaeI0cTm6AMP6mZ8imuRR6dN+
 dS+VwgchE3FAUZHUC4CrUgMVZTRRo1OnrMOEpBmwOOU/jpCR1vkGHPLgFjDdXCT86Hbq9YxAN+h
 Jj9EW4TsfQgs0yg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA1MCBTYWx0ZWRfXyPt3elRYx6QH
 BDyqycKv2EYmlmRieYbZfYZR4IvXop67f5Kc6vYyywhFOd6D2QFkpbZQIbvhAfTusGt4EBUTHWp
 i7s5haAA+jSthVDaafVb7sz1ffzqPpM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA1MCBTYWx0ZWRfX7oPqy4RAQTZO
 aDm4qmY7lmwr9t03Am4UFUJZc+Fj4uZw9UwA0n1xoJvoH4iHXNZbCZK80mQbdbKy9987sDkduzf
 xss95ONtAjxslSJPBx9bWHggQIaJB798Qc5SemFUo1mKoBHOzyhYzPs11A8eYCWmh5Hud2SaMza
 Ka1EyL3RMyC+hXi4UgCMvbLg762MGo9bE1UGh4HAB4MCzzHTyxwNV/Hl62rKgwH9EFkbCcSbkI6
 W+hIGpBEg/asOOJ1hZ/+BSjSHQBt9tq8UXvl1iUXzdWAZZbVEbje7PGGKysLqMytmJWOZ+oMbta
 EwKCxZJDYHw2a5rtR2Pl7HkinCrIWDKJwxPHyw3T2mg1YuQV89xVaBVpMZocPeym/t15Ch4COni
 WvhEuEcyflXS0qizJeqqhrWEBiglR1SkJNAxQu0NjikD/eGxCJO3SLBjWX+BInoDyAfu8ypOsQN
 IaImIcvNgySI88q7CuQ==
X-Authority-Analysis: v=2.4 cv=GZKCDgXL c=1 sm=1 tr=0 ts=6b004147 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=Jk2/TV77q6/E6wQq2oQJxQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=cT0tItDctYQywj5JGBkA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: ZoeOb9qwmMblCGzjPaK2c3oiftaXc2e7
X-Proofpoint-GUID: ZoeOb9qwmMblCGzjPaK2c3oiftaXc2e7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_04,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 impostorscore=0 bulkscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611200050

Implement the property_get_names() callback from the fwnode interface
for OF nodes.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/of/property.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 3a272775a8b7967bc0d35d882a5856153941cef3..f914f0475e0be865afc9753fda5aa40a08a10e25 100644
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
@@ -1712,6 +1743,7 @@ const struct fwnode_operations of_fwnode_ops = {
 	.property_read_bool = of_fwnode_property_read_bool,
 	.property_read_int_array = of_fwnode_property_read_int_array,
 	.property_read_string_array = of_fwnode_property_read_string_array,
+	.property_get_names = of_fwnode_property_get_names,
 	.get_name = of_fwnode_get_name,
 	.get_name_prefix = of_fwnode_get_name_prefix,
 	.get_parent = of_fwnode_get_parent,

-- 
2.47.3

