Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C203A3033E1
	for <linux-hardening@vger.kernel.org>; Sun, 19 Jul 2026 22:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784499440; cv=none; b=m+/MEc2W7YzkeQVrRbFBXnqKDVaXEpCNkiff6bG9ToCAGxtFfpqNiCLdthdjNwzCHVCbAhP8UXo7NveW7szs92MlnMAxL51kB7JXomdntPJXOot3SAtcO2PbZFC6Skeiw8RWftS+TosorkL2/Ef3+7c+JvhOtvORtew2EDOxY8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784499440; c=relaxed/simple;
	bh=WWKK2Y6/JJVXdjmuDmCoTcUjwUOPvrqBtb0/JcU1OPc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fc/ODTTfsnRCQ5YrN+KNaP8DAvgxIAj5oQrVMXjiyYnuqtgrojUBfI2lirGpfRLoaO3rMpBX+D4llfrUuRhb8TOvJkVqQYTfFnn+6LkbtM+DGsDND9XXNB7RBWNzlOyL4h0CHXb2/+pskaO44JU1a4TGAHV0FwR03VI0wS51bzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MH1KFPMy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fr0oxc16; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MH1KFPMy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fr0oxc16"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66JKR3SX595523
	for <linux-hardening@vger.kernel.org>; Sun, 19 Jul 2026 22:17:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nYxQso/u0z9R8HjD1SW36yatESiP4fHZO8aWX+nFPXw=; b=MH1KFPMyjqLBWVNw
	v4ZfEetkG/NMq6eREP3DreSr0zhYrrTgud/Q4TxFnY/KGHISZJG54hTf3o1Ah00l
	Ggn4OCbkOfmGa4/+uSuyq6peB8AXQYlcgNli/Q+tbOqJio8jC+PmqXW5sWH6/zKN
	WdA2tze6dlRWvI4EFskBcE6WxH1o0Kqg2zLJohqFFHhu1bwUJaFQpi+NOEXoN0Co
	8W7o6+Tdhs85VCVkVurO/sm6gHvgnh4CjpaHCga2XCaI3k2pd7l51sJ7i1ptCilO
	qFDerXDC7f+sewBbcDn1EQXB7bQGIkhMf/Erb5H54Ogjp/Lnw/wGfadeclL5JrL5
	tg19Ew==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2d93hwq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Sun, 19 Jul 2026 22:17:17 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c9667280edeso10898789a12.2
        for <linux-hardening@vger.kernel.org>; Sun, 19 Jul 2026 15:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784499437; x=1785104237; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nYxQso/u0z9R8HjD1SW36yatESiP4fHZO8aWX+nFPXw=;
        b=fr0oxc16niLoyrCzpCqD5dCOKyzO/Bt1McxEAPGRb+G+mXQlnXVEjEdmxjlY30KS+0
         BH9YV/zS0W2DoENsytupTaEbdXiInBh+Q0AVV2/1zFIa6WzK6+dbSUOe31hPS+WRQZp7
         4zm+1b9KAVvhX7ti30/hPQkILb1P4wu2mzcLwoUz4THVfoNrC4GZKjKOYjmoINrOq16L
         shJ8XRDceCV0SpVdVKL/vL6A2GOlKMyfTllpkK5xhyCbj2RN9Yq/1uDObbqLvL7jbX8B
         qdlRzu4AB+ECcXvVKFE0drsquJiSKVaKCad8dNyKOQxT5pkxd9ulzCRVf0S4EokTrMzt
         taIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784499437; x=1785104237;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nYxQso/u0z9R8HjD1SW36yatESiP4fHZO8aWX+nFPXw=;
        b=ST/5JZLlJBSYKSaVW5uWyPCmFwB/HYIjD7B8HVw1EX+8XKaVRJ6dO8xpRC+X7a8eZQ
         3yduXeMy6S4tDORBPaJnTwvA1vxhf40GMeMxa9K2W0tzdJs7vsEPlv94BC5Gg7H+DHsb
         MLR1Jdt8gNZU0FJNpkNKV8Fg1S1XygYCLKoz9Zfh/Gcd2VBpDsqcKHcQM+XaqQVEG0wC
         UkJ2zW25QESqMGHr0l1PFKQwmQB/ExiWzVQrpZFf6E0YNO3QEfg7k/T7NeOmlqpCoo0B
         hUqa/R0A8dm358spfWCZznwuhd55XiXLn6Y7TWtICyaIZnYHhg/qwzN/orSwYFh+GhCl
         /QDQ==
X-Forwarded-Encrypted: i=1; AHgh+RpJ3H8eped7T71MnW6q2NTLyr0S9FlBc/JjLjUkPIT7pRaMz5bOohq+FAkrddb6WMoVp48rd7s7BiX4nC59l1g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi38XECHEJQ39n27zhC6VEF7kG6esPKjVOwiXy8fSbL/3kUg7W
	U+FFLvhbxassbp76ypbQ8CppBmMRSVsVeylfLzUpXLRoCR0iAhVhqFcfi2W6HJBg69JZ9MNg559
	L7wy+5rKDr0i2Ashx9tGsKYKPrfvHphuI5lzmbtK3GsLVQKdfM3sByi1R/vy7i/404WRNjWc=
X-Gm-Gg: AfdE7clV0DBguW2OOqPKm+tcm/aNn1qQMlBgBZ/FNYNpMIJYjj8Mwg767wM4wrRvizQ
	ecnEH3Sz80j5bUEOgghWulWIqJT/8Lesw4umNCzHU45CS9CcgfCMaGPr7EpkF5aA5PLWKabeK35
	fzW3/bQa8X4PJi7NQ5ozF86hQ1tnm/4ar1bM+pKSuXs5zrG6U1B+yweKJG/qcYQ0IDtyFTpAK8i
	BE+KApZV6H4mMM2vwK8tEkU7y9edaMx8uzifAJSJeogjsABlUv034qGTaipqp1Bq6GKosmNLrx5
	/1zRJW+Bbj6H8/qMea/eaTy8dVzcKWuMskdIgfwwqOy1jxCfbY96gcxjQfgKvOTXEOnalVOZM4c
	h7LqFXRU1VAm47PCo
X-Received: by 2002:a05:6a21:4591:b0:3b4:7eb0:47a1 with SMTP id adf61e73a8af0-3c3ad62ac62mr12187779637.19.1784499437224;
        Sun, 19 Jul 2026 15:17:17 -0700 (PDT)
X-Received: by 2002:a05:6a21:4591:b0:3b4:7eb0:47a1 with SMTP id adf61e73a8af0-3c3ad62ac62mr12187755637.19.1784499436736;
        Sun, 19 Jul 2026 15:17:16 -0700 (PDT)
Received: from jic23-huawei ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cb519aeb676sm3625211a12.19.2026.07.19.15.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 15:17:15 -0700 (PDT)
Date: Sun, 19 Jul 2026 23:17:10 +0100
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>,
        Michael Auchter
 <michael.auchter@ni.com>, linux@analog.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Michael Hennerich
 <Michael.Hennerich@analog.com>,
        David Lechner <dlechner@baylibre.com>,
        Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp
 Zabel <p.zabel@pengutronix.de>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R.
 Silva" <gustavoars@kernel.org>, sashiko-bot@kernel.org
Subject: Re: [PATCH v8 2/8] iio: dac: ad5686: missing NULL check on match
 data
Message-ID: <20260719231710.14a669ad@jic23-huawei>
In-Reply-To: <alyP8NlQzRpXnSq9@ashevche-desk.local>
References: <20260716-ad5686-new-features-v8-0-ebb0051af5e5@analog.com>
	<20260716-ad5686-new-features-v8-2-ebb0051af5e5@analog.com>
	<alkmAcDvSXr_COc_@ashevche-desk.local>
	<ondynh4kmchzugk2l24klamrcaje3qxnhgiks7gnc46wwwvo35@hysk2zaimb2e>
	<alnknz55FbyyqqlL@ashevche-desk.local>
	<gy2dn5emz7sreavy6kioz27f3sx2ip6zhkgzs2uz4qzecpkrbe@zgsortof6aqn>
	<aloD5HdbntKu--xC@ashevche-desk.local>
	<20260719005533.41520a27@jic23-huawei>
	<alyP8NlQzRpXnSq9@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=HpxG3UTS c=1 sm=1 tr=0 ts=6a5d4ced cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=QyXUC8HyAAAA:8 a=MxYe75D9c33W5Oe7pOYA:9 a=CjuIK1q_8ugA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: fP45OR3vAgLPSC8afYc8vnREkffqfx8B
X-Proofpoint-ORIG-GUID: fP45OR3vAgLPSC8afYc8vnREkffqfx8B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE5MDI1MCBTYWx0ZWRfX/V19Ae7pjM+X
 eLxfsivxYsgnEHSyA9HzhkgtlAWohmJSmbkPjq2EjDPXNMb2NlJutfNnpJzBvQpjqA5fQO359uh
 HlRnY+UsQeD3Cp9NfycHS/RCF9kDJXCdztVtEu8jMR1hF4Ipm8374O4VuZPL5tz032uEmTqwyS3
 FOvqHX5hpCSgR9r26UinEHYCMmPu9mq2B7lTudZB3urc1VtFEh8nqu60zEP2jr6H2V6UP0gWU6F
 YJoETRX80rVT/ABirDwc+91dzgvsTrk72/DCYC1uvQxaEtJJeXgrpkpFFrDgMwVQYqzeEHLbKou
 4e/1jIg9R543Mp1A1yzbVGINUbP9HnJx2f5jqC3oIbyE8075pyfLzM8e8b53cEtcEzZHuReswlv
 F+UsOrGS8A6xmRDCxYxLGA3Mr5ZRkrEvJc2AX/f7gFQZDQy0NyOOR3N3iFqnVn5eOLBkie8ktBN
 vCAvXsRHDeISSHDNjjA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE5MDI1MCBTYWx0ZWRfX2Ej+QoRKz/Bc
 jAGDbduTk6wPiy33x4Mj4KV5YIOcOcaItCHeJgamjyom2iVRacJJxdSDZvjghJjlYj6QULuthIN
 omsZGiYIODQffVHtiDmEeNO51u37k3I=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-19_07,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 adultscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607190250

On Sun, 19 Jul 2026 11:50:56 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Sun, Jul 19, 2026 at 12:55:44AM +0100, Jonathan Cameron wrote:
> > On Fri, 17 Jul 2026 13:28:52 +0300
> > Andy Shevchenko <andriy.shevchenko@intel.com> wrote:  
> 
> ...
> 
> > I applied the following rather than going for a v9 for just this:  
> 
> Thanks!
> 
> > Shout if I messed it up.  
> 
> ...
> 
> > +       if (!chip_info)
> > +               return -ENODEV;  
> 
> Perhaps stick with -ENODATA? (Maybe in a separate change, dunno...)
> 
oops. I lost track on where we were with that. Updated.


