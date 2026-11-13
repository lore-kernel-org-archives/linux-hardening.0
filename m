Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794584839;
	b=bbItuKy61HwvVzCl+Rswnv8oNyLnzfUtw4D1CRm456Jeh/nV6I49qxL2EtpC1SYcxmq9
	 6IcmhWGSzW+ln0Ujm+/eiUxCSOphlLk4W16USP+0jdCfx7F4X+CDlMvROPeLFWSAMf0lC
	 8+FRiLiEjxmmnyVS+i2Sx5Y2zoqBxGR7y1bpeDc+5OsJvFnTHF+0yvb+4eJcym6J8xzy7
	 gzB7gS7yABb6zblNnOwXhWL49zRTim+FCHVW0X0B9cxrawia+dBWG3ExINqK+EUULBT2c
	 Vxs6lhDKkwA+qv6VdVrNogyoH0YWKMNJ4mfq9Zt+Fn17tqJtihqitiqSd2Ti1O22DrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794584839;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=iKlW1GfpE3XIGbjx8l1IseGsgl8DrSMviVv6wGUGyGs=;
	b=zvnQn9PLXGADiIFPmCcyK1Y2BylEOQI8I75IXvdRy/wOLFvzlQAIe3LJlgdG77e91S1t
	 p4jK07PzADSZA94bVvS75E5MJLttfIAnIZrFofysTr75bD+H6YRk9nwXJKRcTEcwAIfI3
	 BlXgC83dODGC/wmQ63oLYxCbmG4E8s5JJ2hA8PYgYTqGxpk2baGXbCG260PIVEJKgzSh9
	 lSIKO7B5zIM0dyemz+dBsNXIaAWD6BrxfaVi8AeXmk069/OjvQVYmYtAxwe1ceC4DmYBW
	 k4M9BgN6u+t/UJRJ4tTGmUqhnFDHjVoODLwuJXHnWFbIh/RvDazuOnOrz8KmEWntbBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OpMr4GKR;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="bRfZkJ/g";
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B67606A8B3
	for <linux-hardening@vger.kernel.org>; Fri, 13 Nov 2026 15:47:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70B67606A8B3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OpMr4GKR;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bRfZkJ/g
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADFRK7K552438
	for <linux-hardening@vger.kernel.org>; Fri, 13 Nov 2026 15:47:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iKlW1GfpE3XIGbjx8l1IseGsgl8DrSMviVv6wGUGyGs=; b=OpMr4GKRlhgCOGW+
	oAGSvwB0vkJOOjsDJOtd3OP053b9V4LeAyAyj8vA0lRFB44J86PJQ9RFxOLDHojJ
	IwXzkvV/h1+Nmxy5xNjiX/x0d1B4/iC83yuZv0evZgcJljZL/cG+aFWElWOmr6gg
	J4tc0bDPU63W8+KVjnyO1SfLgSRhT3rlLiTk4V9GcJmMvPzhCUNolVltcpOuiNXb
	f8URnRdMXrUE3MuZU+8U0SxRPRVWrBS0dUIfj+wKibew0Cef0CwrLrbcDqtMQ1cu
	FteLYwh+SR7/t7hGG2UUMkBi0X0svHdsWsuzgV0jmMEP3n5O8PdW7uAwQPQZsBWk
	P6yQLQ==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwkgwbpb6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Fri, 13 Nov 2026 15:47:18 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-7d2c415bb8fso150570137.0
        for <linux-hardening@vger.kernel.org>; Fri, 13 Nov 2026 07:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794584838; x=1795189638; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iKlW1GfpE3XIGbjx8l1IseGsgl8DrSMviVv6wGUGyGs=;
        b=bRfZkJ/gWn2d0FtIZ6Wl9MdXi9MW2lFMk/zK2V7d4FNyn4MF120e5KPpufjOtyqCvA
         /L+QfIVtJ5NzVrvY5fnNFe5ZMbLeAoW+Sv3tCw9UWW4ctNNHDDXXFun9SrPcVT7g3bO7
         Y9EGrpNyMpH1mus2nYjmqg0McPGOJo/BpuxbrgcWJ9xVw4Q0CVtSHFLjMzmGC0SngXkG
         hlEzHizfVknMnnCy+vl4w4pVYXdhdq0GKV1i5Cfb2Hj/kxV9ke9FNyPJmQCf/UD0nDUN
         Wuy2dqZkD2BCPP3Qow/pJoVlhAAu2OMOUG0QAl+j7PfTjPNZ7BLIPg+nTwIRKkjHcX7Q
         ZTcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794584838; x=1795189638;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iKlW1GfpE3XIGbjx8l1IseGsgl8DrSMviVv6wGUGyGs=;
        b=eIbEtiz7EwXey86mCO41bZyv8ujBVNfoCDROjiEUFhqXnmRjZa0CIFTOo2DSBhe7Pc
         w/8bb7QDGyKka1s2RsyXovAzq8wRt5hg81t3KGoEQVBWjPsfL99evAMwQzLm2HLbW2/x
         KjP14jjdaiNqo+Krg4WQqjsBQg7js50cj2kqShi+vBWWbP62DcIHoYOqUCkMkm5yILMV
         RFK67wJT7JqNNVzlXGNepN0n/4KPM4WlWIMNPrKvnrv+7OAPrTXDBEeBkQjgtzKpDBZC
         FE2c1vLd19f8FnWb4V1B9eXj0J8mQzzouMaaZ/OhHIPc3PgbnDTsBDkeMS1sNVgGlpUZ
         mV8A==
X-Forwarded-Encrypted: i=1; AL+hErFY0qs7EDh/rfUS9s8spxp1Gn122w+p2Wq+l4JfP313Wl1IT8d/Yd+sO1OfDJEFMaus3ngylq0CVmGU/8nT07w=@vger.kernel.org
X-Gm-Message-State: APuU4Z/SKgiP2W2x4aUtLNyUfT2BOcNseTceJlD0wsQ87apKCfzbs5Cz
	6rltOb4Z6sz0wJJlEJ7O01xRmKC2jLCdJkj+Llce81rR3MrFABuEpOP9rl0e8PJqCr5o0LQcIY6
	IoL82glSjmqaNob52XHGYfffO4yTt1vlu5QTUJbyWHUIob4RkLMIsRE6RaczEcagxCAlhOL4=
X-Gm-Gg: AYBFou3CPFR3nUj5MyGOxiCeBvGnTIWsKtx2+aYCfy4W3GrnnAM0obkLcDYC1G5x3Gz
	zCb6AZamluptV1hkBPDEC2Zh4w3VWpnuKfYtax9WTdyQKG+FxVrswVZv7BmmFNYjjnbjfnBeP38
	93/Mw6vH7YSAoDbY1ilbRlizdkvMBloz4K+avwy3S3cUvpupX6PzXBqGXc+gknkUw4CK+Ax/aGv
	/UhUBuwXR2GMozoTP3vYNtod170WJdHFK+NKfnNXhtjyDMN1d47haCct7WGIKRBqS0PezYEYYRG
	KnRXvueV/7iRsVXIM3kwb5EZewGo054y/zrLPbVhY7S0XRUlFt3nYcZZdQVbgZRssVT73N7DtBL
	U8pDIM34gf5Y/9z7dLB9ZmALZaTl9js86cvMxyqvh2yLchYwJEeMIYlODgZR8L4j4/StpLPtRZW
	C8aA==
X-Received: by 2002:a05:6102:511f:b0:7cc:776:6c41 with SMTP id ada2fe7eead31-7d64d770275mr763674137.22.1794584837836;
        Fri, 13 Nov 2026 07:47:17 -0800 (PST)
X-Received: by 2002:a05:6102:511f:b0:7cc:776:6c41 with SMTP id ada2fe7eead31-7d64d770275mr763648137.22.1794584837303;
        Fri, 13 Nov 2026 07:47:17 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5f5972a7sm5636519f8f.21.2026.11.13.07.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 07:47:16 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Fri, 13 Nov 2026 16:47:05 +0100
Subject: [PATCH v2 05/10] of: property: implement the .property_get_names()
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
Message-Id: <20261113-fwnode-for-each-prop-v2-5-4edc23d5cf50@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2119;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=ByGt0Wun0kTw8gtxY07rIdqBJJaAvKUMm2U7zjbf8qU=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBq9zD3LzKXZG+ZjU7qzjenQKDou5yHKCzqPZhLQ
 LzzR+h51yqJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCavcw9wAKCRAFnS7L/zaE
 w/4ID/0Tt+LpyDARJ0d+BKtRxYefGN4cbRKTHJQr/JXKhlbiMKuR3UoVMhLlfPEuceLcw9J3WBP
 SvKR0EoEih/KGjO/UqyHitem7T0QiX2cTqnOrTSKh6uAyk3LUPv3FY2d3xuu0OmzhAeQ3jk0cI8
 RrMOpg1DtAxOIDWXvabOm1fvI9VL2yJNp4GJIhBcx2Co27ZYFyPs2v0ak5YVwfOcg3NMR+7QX1/
 2m4xf8zSJRKcpDKNkOIvXDlD8qDBpqGxbubXWWFKSZI4TpSplk0pgBNN1cRiuu8O95IqpY7oD0b
 RTTjmG3mNjycBgmkGnU6k7fIai/GrujJRTfT6fR2nyWV6ukXzriiIcmETNS/dnjeZiC9GYP7niW
 EJDCjGqy7IT7D1+xizEXPRyQdDAyhpuHmAEPC02sDHOfZvwWm6fiAJ8P77QJ43XzC+6JRPpyAkF
 6e1MXWQuf/EmEHuL+kA8f4DY/e6qsqW+64N5ko1YD6tgJ1sZvx3Qrr1bo7H7Vlnoh/SWh/jM7SF
 QXY1dyx0UYw4j6VTOYkOjP21Cf8osZudyiCM5Meo0O4W7kxrzx7PuxxUKVB6pmdaPH8BI/uQi8A
 VWzQEszf1wul0oBLEBVAoRkXz0VmH9jVO6ESDGfdjl2i8ojONLBEGXiG1rIf60+KHl7g3NePFRK
 ADxUtbAmYECsXnw==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=DNgacCNb c=1 sm=1 tr=0 ts=6af73106 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=cT0tItDctYQywj5JGBkA:9 a=QEXdDO2ut3YA:10 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-ORIG-GUID: ovy5F6VYKT9y9LpkCI-lL5np_YqS1wpy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA2MiBTYWx0ZWRfXwnZVIfsMsY2o
 RC5wFhP9/Bqbz0UQ8OgnUAOTMLZQwfoN5cNis/hL0pWC0RKlcDhe0FXbiInssyKcy2tCcJyHyJa
 fLpw98fvcBwyQqj6xUnJbrXgYIcubAjdweRjdmdovwH983e1Ev70VMVL6aSqUSAWm7bYApXC0/Y
 kqOGXdxo/X3RQCpQCH9gEcfzevEKVUFDRIGa/xttD1IqdGu8rDndyl4vdKK1h3VS7Vfs/cNzbNp
 2EWOIOaT0mvHErTjwRkZQzaHd7Xy0++r5Sd49rc3MwwknYU9to8P0VezgQC8LJfvMpbpIkDRWZK
 /aDNfC7+1baR4o6DJu2QaLEL0eakqIJVPqDIGgr0nTuvkUThUrmZEGDnTJaHqQjQ3jH5qEu7aW2
 k/9VVCcU4PBLqaejMldGC4U2QfgTZB1pSMt+ZfhS5cH+qFAmRuIAAwBuB6pdQm8b3PgIuasW2OB
 ayJRSTtw2T/8fv3ZKaQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA2MiBTYWx0ZWRfXyWf1giD5e5vm
 XEF315/gPiN/q+lLSK4/KMLngN3VrMlicVpLvkdOW5KUiyoFF6Taup2z6F4BFuSrnI2D8/CZHht
 PYl6pHZ0nAZLMb+8NrzuR8Qv+zLUjgc=
X-Proofpoint-GUID: ovy5F6VYKT9y9LpkCI-lL5np_YqS1wpy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130062

Implement the property_get_names() callback from the fwnode interface
for OF nodes.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/of/property.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 45e55f61848801ed497702c6cfe501009904c49d..53f2c84bcb96d3a00f3cd2371010628493d49bc4 100644
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

