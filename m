Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792952675;
	b=eOfYaYAsjk/jh/4O7fyfsrgT7L3m5YO4B28UoBloVSADKWhUmD9BjOG21GSdkFMKoPtm
	 rT7wH+Ozi0Dc20TZxmA3oWifwzRiSBa6Z6B2oFyc0KOz/Diu1ZZUqZS4PX3p+RactG0li
	 5nXXqxAt092+7IIyczy0rsCV6JHN3GaIrQ1x3gdlju3qlcwCUZ0woFEt4wpi+8iTD4i01
	 WX+TKmOQ9R/9q8t9NEpc1uaLFFSlBg4B3lFJnztb1UbvhGSGvga9rhkfM/Jvb99FMRILX
	 wGeS3sxUx/feLckpe1FEse9NeocYSwIRQJgiQyeaoGpExM/wIL7GjLaxS/7A9luBQKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792952675;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=9VGC46sOjb1yqds+5TUPJXAXqq+fPQ2Z8iTIhDhwZYU=;
	b=CdZlSLg9oZi2ScZxrGXNYO4HQzXmWUxJY8yE6wA6G/av4LS1qWiVTAYl/XN7D3GNShjY
	 xHTm8Y4TOHJmeenE70p9cdngiUTTcJ7TU5PT00tAJFPLdZrH3QD4MDoZDWK3yqfRCptLQ
	 PWvi54OT0yqWqLawa6d6/xnNsopDHnGh58Al6KaZR3ICigZMIcDlNf0I3XHoze8nWv8ys
	 i4tE+2+vYDPTl27lDiHFnW8rhgP2uem9JN44+0N3+8LtFnbcf+7DojthjnGTj9dOT4Vvj
	 rKQDyvM76sxiwmv2a9VpBrlxXNHTgMVtXuhZEv8V8qJS6D1lt1KxzXSkkcNYPBB2y5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gdgFlyCN;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iSoYcsmX;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9402606A31A
	for <linux-hardening@vger.kernel.org>; Sun, 25 Oct 2026 18:24:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9402606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gdgFlyCN;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iSoYcsmX
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69PFk20E3811500
	for <linux-hardening@vger.kernel.org>; Sun, 25 Oct 2026 18:24:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9VGC46sOjb1yqds+5TUPJXAXqq+fPQ2Z8iTIhDhwZYU=; b=gdgFlyCNNdUfWSNx
	IbUf0XKacDJKPERtNschfH/pf/9F5o+CbkrZHdj8K5/6Xw1mDEG7Xc3lVDDnxP8s
	6TCZq4balz2LXskIcW7p0ZAo9vZzso1JpB3xFBLczagleUZUUOAxLdXlj28c9cNJ
	oCcCCCQLHU//gFCJZ5WklDBdXsbCXNdwaEmiKz1yzC/26qF0R5gP605sD61FlJKJ
	kGlIZKjNcuyZAQEpUN+AzkuvmaZYzb1qttBfnNC500nHq1NQ9a8zOD+oS07ib6xU
	VumtzowtSe1VRmhFGesPPMs+QcZoi4aJJ8pnbDmodQNUyApM7ztM86bffAC0YCVx
	fatJwg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgn27umxr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Sun, 25 Oct 2026 18:24:33 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-35a04491c56so2071756eec.0
        for <linux-hardening@vger.kernel.org>; Sun, 25 Oct 2026 11:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792952672; x=1793557472; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9VGC46sOjb1yqds+5TUPJXAXqq+fPQ2Z8iTIhDhwZYU=;
        b=iSoYcsmX52TGT1NBfy7a+eQXcgKutwd61SIwRPKhHpPI4UrLy7I8CRr1ayHXws7zhD
         iQ+ddmmwMlsRfgaKXdkfk/Cx9LiKtuG6q32ABhwEw0DOoywKSLEJX3xW1MPrr+mK3/In
         YT1NL7oEa8Ue/Vll4Rwks0OEpi7rS8nE0fhjjnfHDA0ygF9FRJon65eq1homBRRcnrYa
         dsZ5VNi8np7mjazP6UOPQHSOwC5PuckkS4uClV5OzOSJLnLN78A2Oq7DVjFpSGTpVM5k
         LOu9DWwxQdQ6c7t1xwO+KuGXIb7IahJ3qmV75c0xth2Qw1dHTV8F1PER5Brj2Cr00Tzs
         xbyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792952672; x=1793557472;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9VGC46sOjb1yqds+5TUPJXAXqq+fPQ2Z8iTIhDhwZYU=;
        b=i8JC7ieTWLh8xI9/ocRJwfxgx46kzvB0s9ZO9fQL0sxyYc8ZMwH4IdHvyB1qhEncrM
         f2ZNrDH7Qd2XI1LkfqJ0AMsC0kD4efcyTMMxnSxOzAO2aPnBZucJFdMy4GB5I3dz70aY
         az8lVf6WPt9u5pk2CZsBErzV37Qy2cfyHPAnIsTpj6I789q08Yw9kNA0sxsI9eSt6x0x
         oXAOuBgZbnsZBvrK+2X4Micaf9bAcJW6HBPjeb8jbW6QuFDGHbhjO3+AsO8PMi7tC29Y
         HtZWfacTj17icFcvxJ7hO2fXUj1T5XWZeYFNbGliSADBCFd1NINBohWWcHo9n0Asxxpd
         n/yQ==
X-Forwarded-Encrypted: i=1; AKwUvBy8eATN9Px75PcEFU0zIx84lEXQD/A1KobwY2naCiisWOi32xAGmk51cc1TJCnTNOr1WVeZhDmmPQqJHAOp0VA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLuQNYZbhtKMXmiqVD8PCVZ9ioo4Ki1YjNzXnNT1dodg+ioZyeg
	T+fXKf6TbyQMH7mGNZvRJ/+/AgUzgRH2uHXvat3nqT7tbMuUJwJldiUlaTYd6C7l9Fx3/4JfoUf
	s7YOkOQyafH2WBHjQSshw2vABfoC7Dhn0ZHTNcHgrCBHMdt0ptyDdd07RKWRF9AyVc6lf/OA=
X-Gm-Gg: AYBFou2VyYvRcJJRDLVOjtiNGvg1MVyn//y2LxOBdlEw5z6/rGqlMQ7OWLCqPDdLyJ/
	YLq7QxssvAWBuRlSjobXQF+QFZgquu7JQqHmPrFhsRf77QdsAyd+IT3B3jSB18bDYzIXf366ssf
	14qyoYWhaAvqlzoih0zAYcVJ3HAMGY+kCLTezGs8W1vflGL225S4XUKwcf9vJ/RNMQPFAT+EktU
	pgJmYz0HLJRhJbDtwFcV62YXNlKEFqvTKT0cebuoF0vHNvH5EgFNJ/c9kTUmoIuR5zUzD3BdgcL
	UHvOI5in6a8QGV2gDi/dFGbdNvPq6zU2OBEJ3/ma6/c8/6MSMvBUNgIHYU046RdtIjPvCuWIyWa
	QnbpWyPMV0WPKKQ==
X-Received: by 2002:a05:693c:63c1:b0:369:f1ca:5b24 with SMTP id 5a478bee46e88-369f1ca5d7amr4290310eec.6.1792952672260;
        Sun, 25 Oct 2026 11:24:32 -0700 (PDT)
X-Received: by 2002:a05:693c:63c1:b0:369:f1ca:5b24 with SMTP id 5a478bee46e88-369f1ca5d7amr4290282eec.6.1792952671668;
        Sun, 25 Oct 2026 11:24:31 -0700 (PDT)
Received: from [172.31.0.30] ([136.59.194.171])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8d8a690sm18061188eec.12.2026.10.25.11.24.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Oct 2026 11:24:31 -0700 (PDT)
Message-ID: <a23ddd67-14d3-48ea-9ec4-32483221c465@oss.qualcomm.com>
Date: Sun, 25 Oct 2026 12:23:15 -0600
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 7/7] riscv: Add RISC-V Kernel Control Flow Integrity
 implementation
To: Kees Cook <kees@kernel.org>
Cc: Andrea Pinski <andrew.pinski@oss.qualcomm.com>,
        Richard Biener <rguenther@suse.de>,
        Jeffrey Law <jefflaw@qti.qualcomm.com>,
        Joseph Myers <josmyers@redhat.com>, Jakub Jelinek <jakub@redhat.com>,
        Martin Uecker <uecker@tugraz.at>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>, Jan Hubicka <hubicka@ucw.cz>,
        Uros Bizjak <ubizjak@gmail.com>,
        Richard Earnshaw
 <richard.earnshaw@arm.com>,
        Richard Sandiford <richard.sandiford@arm.com>,
        Marcus Shawcroft <marcus.shawcroft@arm.com>,
        Kyrylo Tkachov <kyrylo.tkachov@arm.com>,
        Kito Cheng <kito.cheng@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
        Andrew Waterman <andrew@sifive.com>,
        Jim Wilson <jim.wilson.gcc@gmail.com>,
        Juergen Christ
 <jchrist@linux.ibm.com>,
        Dan Li <ashimida.1990@gmail.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Ramon de C Valle <rcvalle@google.com>,
        Joao Moreira
 <joao@overdrivepizza.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Bill Wendling <morbo@google.com>,
        Osterlund Sebastian <sebastian.osterlund@intel.com>,
        Constable Scott D <scott.d.constable@intel.com>,
        gcc-patches@gcc.gnu.org, linux-hardening@vger.kernel.org
References: <20261005154028.out.839-kees@kernel.org>
 <20261005154039.1464721-7-kees@kernel.org>
 <45190057-a50b-40f4-9502-e3001fcac67e@oss.qualcomm.com>
 <20261010075835.446f27-kees@kernel.org>
 <68806dbb-8a7e-46c7-9630-80c60de76a27@oss.qualcomm.com>
 <202610242052.5C74E1C95@keescook>
Content-Language: en-US
From: Jeff Law <jeffrey.law@oss.qualcomm.com>
In-Reply-To: <202610242052.5C74E1C95@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=G7GJgNk5 c=1 sm=1 tr=0 ts=6ade4961 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=f0mOnocCY+QlKk/R9FCP2g==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=-QoNpgST7O5EbhNJQ6gA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: w2N2ZwnGniydjVIFqBiLzLgF7_lcQnIP
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI1MDA3MyBTYWx0ZWRfXxsAPVvSTOVlU
 NFaa+0yYFAlGH+fJdQZ/M85Sr+BHZwXbjdBIOXwR5ZtzfeMliuU+4DYaOwuEKaCBjYgbZkv5D6K
 CeOw4hBKebRGoQMHdecFdekquyI24vY=
X-Proofpoint-GUID: w2N2ZwnGniydjVIFqBiLzLgF7_lcQnIP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI1MDA3MyBTYWx0ZWRfX/rSiD8vv7IyZ
 i+uXgpEXaw15uuGJHk8R5OYChp5m6zj3GRNpCr3SHCOpiRWAEc/TxJGl2zFA+xl+NwqRdQ7COZl
 uwCOlRgi3YL3MdrGcoP+hKtkCvWBpSWfeJkiQVEokAMYqheTXNf5AMqlNmTBEgiq6r9nAvGr9D1
 nLsjawJ5CmXYgJnB1cmDR+EzM/D93CFAreadxUYKlVihzhXdMiJUZZzfqvbhXLzy/Lt3bfNeNS8
 i9QLkjk5MXjaK08ErZJMU+lEm8WbNuBJV12h72v95bIe9MAPs0jsUAf+ijfleIz8+A9rpS0NHaZ
 qvHDeotQH6lgcfSrZZANhL7gOh5Ce67uEvgKhhZpSC+2QfmX0vT4OA3YHDxrIf9U8Btq+R+JNvc
 NxEqCl/YHrmCYW9uNreWF5jktPikC+bYgjkJ/rO4+z8dFWobUUSRSwspePs5lvG0Oe1Iv5JY8AA
 aFWXiKWLmJIKX4i4GtQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-25_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 phishscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610250073



On 10/24/26 9:54 PM, Kees Cook wrote:
>>> And trying to create an entirely new mode of register allocation for
>>> use within a CALL_INSN seemed like serious over-kill, given the other
>>> narrow constraints on KCFI.
>> Certainly wouldn't suggest that.  Just seems like standard mechanisms ought
>> to be working here at least at first glance.
> Is there some way to have only an input reload? I totally failed to
> convince LRA to do _any_ kind of register allocation for me in these
> sequences, and boy would I have preferred it do the work. ARM was
> especially gross for doing this by hand.
Reloading is based on operand predicates & constraints, it's not 
something we get direct control over.

Essentially the register allocator does its thing and tries to pack the 
infinite pseudos onto the targets register set.  In a perfect world you 
can map all the pseudos to a physical register and the physical register 
chosen matches the constraints for the operand -- but it is common for 
there to be too many live values at any given point or to get the wrong 
kind of register.

So after IRA is done, LRA examines every operand in every pattern and 
verifies if the operand matches its constraint.  If there is a mismatch, 
then LRA will reload the value so that the constraints are satisfied.  
LRA will examine how the operand is used to determine the kind of reload 
that's needed.  You're already aware of INPUT, OUTPUT and INOUT.  But 
there's other cases.  For example, you might need an address reload for 
an output operand.  So it's an input reload, but used for the output 
phase.  I don't remember the name for this one, but raise it as an 
example of the kinds of scenarios LRA deals with.  There's an ordering 
and lifetime defined for each type of reload so that reload registers 
can potentially be shared. So if you need an address reload for both an 
input and output operand, you can often use the same register for the 
two needs.

Jeff




