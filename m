Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795178831;
	b=V9NiatpLZxZQA2/XuptiU3DR0QshxeOYdPZb/X0FTnJ6sgTcdA2gJFISmhO7Ms7yn7m0
	 ZGfv7y8bjzLctJsHvamU3qBeM61sQ9nhyf865n4sV5qkhuDfU3IXRfL7JZTM4WEZGzvWl
	 +2NHObQzlUZn+5ju6Mbk6FlWOVlxgmOFtKhCc/pPRz4bayjZgAxDe0+dzxu8x4f7Xx8dK
	 7gn2KxcHwDDqd0mWt9UgEbt+tJiR/LjqjdRpQDSevG/ah9ZXbW/EgYaeE5uaB1xMv+5MF
	 ImNPZus3/P7VkoByaKqZtJYYAO2t90DaXGT3waGVC0Cp0oci+D7Tuf2sQ+wZYbZl2Pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795178831;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=itd8Y+uchN2HJrYq4RSPlfZt/iDxc9zWsOFSO8a/jcY=;
	b=IrGDFdSgkwjOGMW/lc13LTolNyXwgs7OzK8uMIhORJXo10ZuvOcRfaCzQaEJHQW1B7mO
	 vcrBE/qFZO6UB7Bio0ol76D44xJdUZfpYJdWtCAbwc5j2d2pGtOtTXsgo5D3hltRFvWxd
	 tCR7cLH0rG8JPOHXSJT7KLkzOYUw4jXv+Z9VuIjU0gDc4fRtD5H3H5CUTd3e1qgAgaEJL
	 xQMItoQg9koggBVp9A0O1NUA3PUpllBDdShyRUNNuSQbRu8xq58BFHMJJgziaA0OccqCy
	 VJ/yy0ibMYjVrUHOe7bFAPhYQBxRBO9SLvbUIE38fGBynkce7x9HeCKH5Qzj+AmOfsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kAGwoYqj;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TmGmxgRW;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF5360A3821
	for <linux-hardening@vger.kernel.org>; Fri, 20 Nov 2026 12:47:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4DF5360A3821
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kAGwoYqj;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TmGmxgRW
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AKAkLFm1170033
	for <linux-hardening@vger.kernel.org>; Fri, 20 Nov 2026 12:47:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	itd8Y+uchN2HJrYq4RSPlfZt/iDxc9zWsOFSO8a/jcY=; b=kAGwoYqjsmEOPEvP
	RG+KpqsE5zTdml35zlezIrOW9bKHXwW2kZmk6LInh59yRJVcubAJlwRE6yz1eQp4
	tlIpsbo0fM3C7HjmfNcN1gBnKO3TCQy0Zdn3vKhEt4+cXYIbrcCxc6DwuwMoLVUc
	35bGjsWoQRFJrZB+tzVKEzXnTnraP6EJ2tllQ2IyYqwCYKLpvfk236uFKkFkjcnm
	gRjtbZCM/qHwJ86d8OXDIBHXk8l5Ww2xRQeE6mRLm4x1d0k+DYqbz+phvoRNdxEH
	QIHP66dFfcFigzkpoAy5Xcqap7Ybg5UqUEa7ZXXl8pZg9NjSzhXZFzRV4HUitGzv
	6J335g==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j27b5usfk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Fri, 20 Nov 2026 12:47:09 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93f32050e72so237691385a.1
        for <linux-hardening@vger.kernel.org>; Fri, 20 Nov 2026 04:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795178829; x=1795783629; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=itd8Y+uchN2HJrYq4RSPlfZt/iDxc9zWsOFSO8a/jcY=;
        b=TmGmxgRWsXd259IxhNqKkaquWcUbQ1YxkSbvMmJ+zl17/5e4muoMaWxg4R8aIveeP/
         TisVKxeUWQlQ6lw6SbXstYcKAm0OLDSaJYHkTgdbKYm+Rns5Qe8Ql6TPb9rktTe77GIa
         Tx7IRkNC0NNIqvVca11AbJRA/XVo00ugUgCNrwFwrudaCzZEllg0KwqcsxNYPAXf5DGI
         doMZNK8QzK+rlPivkKCH7VamQ9OqJfABKHA+oyr3nM73mhA6bN8zeeJf+oxtHiBcGLYX
         JnYDwUsmaLoJFDE2WAKEaL9DU0a9HFem2G/Z8J/bue+GQW56yA04fPYlSpOAWNAUapGN
         WqZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795178829; x=1795783629;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=itd8Y+uchN2HJrYq4RSPlfZt/iDxc9zWsOFSO8a/jcY=;
        b=SnUzx+H2CLbBh4MMJO9SOsCONhdayFJUTqabcJapQOLz7yxSMDmZoNOA56PuSFQSdE
         P5eTD2FB3Vt1kn5CHqcsfZpkWmxLcFuZoRHLJt1KB6pp1EhX6F2RUGA9lEk5R/E7wLkA
         7r7mxDiCObuEUHFu2Wk04oWg0ewGrNZw/ze7tHQOnfVrfmxYuHfNkUt1XjstbEf3EF7D
         lP996KeyfH45uTW+PgI4WX3WibYRuZ+3xmzMbNjI8IScn6Mmx1oFLGXsbOnZpBxbHMry
         2kuyYHv9n8GvPSRyn82Dp47zPEGlQe9cM+eM4VcD2tZia+i/uWRr9OBJUBUzDKJItTz4
         ajvQ==
X-Forwarded-Encrypted: i=1; AL+hErEeZwn3SPxxY4n408mNOdz8V5v6c65gEX1zBBn5TFULJh26s9C+U9vBUXiSMyctYUxHf1Ybvjw3FghE1Jmuju4=@vger.kernel.org
X-Gm-Message-State: APuU4Z/5HA0njH6BsJj3u5hbI3jiod6R6nKadvosOQy1Dfbm5z4p5M5Q
	1+UB1Yu0Xw6M32L/aw/O4dr0BrFVpTSxWBaQDadB8kQ6OvRTg/e9vIauj+eOwLzStzrQ+77vJER
	CyrXNWOqyFWaQxwBfZJB6hF54XSk/NzFTP5I+fEe9WLhE4JvHjtCHHDQPu6ZBBUhUEu7vhsE=
X-Gm-Gg: AYBFou1cJYazAabh58P6cob6Gl2DJASUACisxd68/KzRU8D/QY6tcd/8NuTRNmpXry0
	75J/MsBNnI2eQNeOr6Mmq6NdW1JT+J33jxarTu9RVHTe7u/0ix3bGDqVbpBpqhzSXogiK8eRU4Y
	MHcBvWmS0PdTTx5Kc+0JRw4Uro15E9Pv5iBQXfJeuHfItz0nCxeY2rp8VRoiwbOYYhhCFjCm/P+
	63WhiWIaj4NzWc7jGCBbkwrz82uoQQ0nsgEqLbBrD7CDBOA8D2dUYb42T+356r37I2OVdp85Wmd
	J0G7SB6eDQLMQl8pKdkxAQBwulKswWwfl12H9b5NdFOadDbfULcnDhdSvwnzC/mIwjNMbN9qTg5
	4I2vhmC1irhcd+eo/y8JZpBIoclvVYS/Ov+6Aiy020PFo73LYZLdwI4bxjAFsbX2u3J6wM4YGP/
	k=
X-Received: by 2002:a05:620a:4453:b0:93e:c12c:fbba with SMTP id af79cd13be357-949bab47df4mr465802485a.71.1795178828526;
        Fri, 20 Nov 2026 04:47:08 -0800 (PST)
X-Received: by 2002:a05:620a:4453:b0:93e:c12c:fbba with SMTP id af79cd13be357-949bab47df4mr465795585a.71.1795178827983;
        Fri, 20 Nov 2026 04:47:07 -0800 (PST)
Received: from brgl-qcom.local ([195.50.164.66])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884ab091sm119248995e9.11.2026.11.20.04.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 04:47:03 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Fri, 20 Nov 2026 13:46:43 +0100
Subject: [PATCH v3 06/10] fwnode: define the count_references() fwnode
 operation
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
Message-Id: <20261120-fwnode-for-each-prop-v3-6-808e304dc73e@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1638;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=uLLErtVyyBCCkNg/MASZUF+mZGiOHH8LUrLC/RKjXs4=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBrAEE3uresk7TAtJ8rliLvhk3SedImd2uTEfvXz
 2xdszcr3XeJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCawBBNwAKCRAFnS7L/zaE
 w6LmEACYmRIPS0gPFt2gflTXMQeY2t8+0rQqwmjThzMGX0djCywgpXZ3HDOGp7XitV+81T0yfY8
 iKtdUOG5Zvi5dJSBWI6R3VZIyFj/1NGOMWOCuti5JkgVqm2Tve3KQDazZJwgjZfvaPndgpbw5KP
 CxYXQ3YftxvsbooRE9DQkRSkZ056NIaRtJWUH2a2w4QVnS/Kmfk0ZD3/SmwAgaHkm79Ma3jpAWP
 Mu0Ke9tCPBAaochJ+RAJoMC9jRWd5Jkbzpa/wW2xDiTn8bK8IleJivLvnxnLFQi6jSencLgOGPp
 m7P+g02A/eeTZUsnHXUnVE5ZmOYo15yzDN60ErDsZu/98O+Ch8PeVd54PVyD3rqpbqWjiAyPAa7
 kGlp9G57fMEZv57qUFcZPAx85AYSNx0W/FmaXn/vbfvMsmIAgy9ve2HFXeywf83gr59lsdzfxu8
 ODfZeZ6XXhefRH7nQZFgHxsE5T3yEFnpqGJVJ9N2z8sIw5PQ/x1lJsIz7F8GillN3O0eqPPUroe
 fnB7/Jec2MbvozCzZXSYBdhnVzwWhxUZbsTVch1xl1gdhj6BjiECQCvPol4hby0jzwZubuJQ7E3
 21kBn2CKKGgGfGsMti+vvqoAJ/0QFEd/SnRz+B5Cyvo8Bp6LC4+35IOtDzTHSCVaJohD9Zji5bl
 8quoz9OFXG2XsSw==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA1MCBTYWx0ZWRfX7WGlWLi5G/77
 DnZLyiX034LRC4z5tRRTx/COMtKJ8RluITkaLlkHMuu4SntRJ8HNRCZQILwgwWRd7HCjcUdhefF
 hA7JrIGnXKUdFTk/hgQwUejGwI0Y1Sc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA1MCBTYWx0ZWRfXxR3SYhv42DZT
 Q8bzKNrUnLFjRh4UvYUz/TCIlHwtOUEp9jX6hGlwsrjMIeNOANWHl0fk6xu2uUGkLkqzpollf0Y
 qDVffrnyynYyaBWh5YdB55HGhQGPd3sxPwLTfTFvk4uSjkOtZY3bZ4neIr7b6qbNhlsDGDqwDA/
 l6wMJ3IaXFdZuDi8bzOurgVjKQQQx1TrF0uJ0X689u21xh2tQInNT09slOH5QwSvqovInOtxsJ9
 KW2mlUKPde9W3EglCcjtwl6hysTZGjvlULtZdM4phC0eqRUpJexzU8n0RWoK9DMYo/398Bm131X
 xsY5R15ZRVcvAGsNdwgWXVI99pHGXSjya1sRxZIHMF92x2x2oJtPpbdP5U67uFLZN3Xa3Rq4sb9
 KRV6AbcmePsi+55jcnv3iA3fmhSq+rKo63MLUL76iIjJv4YXp5XB8rnQC36pLZ27OzOXG816zL8
 EWgfzOZcKK/Dmi0nPZg==
X-Proofpoint-GUID: clFnj65e_EilT_LFGuKZ7f8J9a9Rwt5Y
X-Proofpoint-ORIG-GUID: clFnj65e_EilT_LFGuKZ7f8J9a9Rwt5Y
X-Authority-Analysis: v=2.4 cv=LPTz05W9 c=1 sm=1 tr=0 ts=6b00414d cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=Jk2/TV77q6/E6wQq2oQJxQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=pu8Hlg4PHyDR7New1bsA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_04,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200050

Add a new fwnode callback allowing to count all references of given
firmware node.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 include/linux/fwnode.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index 2d7e0b9245d445d473c7317bd27058abe5750b40..15acade60564ddb5f5a48f2235b626466d77dbdf 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -137,6 +137,10 @@ struct fwnode_reference_args {
  * @get_parent: Return the parent of an fwnode.
  * @get_next_child_node: Return the next child node in an iteration.
  * @get_named_child_node: Return a child node with a given name.
+ * @count_references: Return the number of references in a property, including
+ *		      empty ones. @nargs_prop names the property in the
+ *		      referenced node holding the number of arguments, if NULL
+ *		      the references have no arguments.
  * @get_reference_args: Return a reference pointed to by a property, with args
  * @graph_get_next_endpoint: Return an endpoint node in an iteration.
  * @graph_get_remote_endpoint: Return the remote endpoint node of a local
@@ -180,6 +184,8 @@ struct fwnode_operations {
 	struct fwnode_handle *
 	(*get_named_child_node)(const struct fwnode_handle *fwnode,
 				const char *name);
+	int (*count_references)(const struct fwnode_handle *fwnode,
+				const char *prop, const char *nargs_prop);
 	int (*get_reference_args)(const struct fwnode_handle *fwnode,
 				  const char *prop, const char *nargs_prop,
 				  unsigned int nargs, unsigned int index,

-- 
2.47.3

