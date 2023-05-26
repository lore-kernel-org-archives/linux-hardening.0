Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A8B5C77B73
	for <linux-hardening@archiver.kernel.org>; Fri, 26 May 2023 13:43:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbjEZNnb (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 26 May 2023 09:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjEZNna (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 26 May 2023 09:43:30 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7FE7F3
        for <linux-hardening@vger.kernel.org>; Fri, 26 May 2023 06:43:29 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34QDeF1t019979;
        Fri, 26 May 2023 13:43:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=KE32+e5BSPpDvnp5yahUrFQX/ubbATDMCPYxGRsjHTc=;
 b=VZAIxAu14xUZUQil9CHVv8wwvi+f/JaNiMOv0IaNl2DZkbipW548Z5T3ckQNwAntoiT9
 Ac3JdFODuQjxl3E3RH84wtSqaHTkpCH6DI9ZuTQUnCxiuEbqPcaeE6h6O0yaynpzjWO4
 I6Lq7AHuqRaz9mkTWnAjzEnH4m88aWy0GD06ICBo3ai9+5gOu95daTGBsE4g2im7A0Z7
 ycW31lN910avLDWHwmOdwT7NHmymYKiNWDIOBK1qTHj9M+8/NVR6q7rtv5HAXs0NzXXM
 RVLGfFSHz2FzbU3gmleewweGO9dxVWQgr4f5XSxFLeo2inBRHwmfWVmAd0aMhxOI7RcA PA== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qtwn30asw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 May 2023 13:43:04 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34Q74hgR030010;
        Fri, 26 May 2023 13:43:02 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3qppe0adv3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 May 2023 13:43:02 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34QDgwYu22413876
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 May 2023 13:42:58 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7CE7820043;
        Fri, 26 May 2023 13:42:58 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3486420040;
        Fri, 26 May 2023 13:42:58 +0000 (GMT)
Received: from osiris (unknown [9.179.19.168])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri, 26 May 2023 13:42:58 +0000 (GMT)
Date:   Fri, 26 May 2023 15:42:56 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Kees Cook <kees@outflux.net>
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-hardening@vger.kernel.org,
        Sven Schnelle <svens@linux.ibm.com>
Subject: Re: s390/defconfigs: set CONFIG_INIT_STACK_NONE=y
Message-ID: <ZHC3YJ3FHwYxYrMG@osiris>
References: <ZG+rogQJO+U3kS4a@outflux.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZG+rogQJO+U3kS4a@outflux.net>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: O60-vatDEsjLiTKOlw88EDp0ptxETYOn
X-Proofpoint-ORIG-GUID: O60-vatDEsjLiTKOlw88EDp0ptxETYOn
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-26_01,2023-05-25_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 mlxlogscore=999 mlxscore=0 spamscore=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 impostorscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2305260115
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi Kees,

> I had this[1] patch pointed out to me, but I couldn't find any discussion
> about it on public lists. Can you give me some background on this? There
> haven't been any general workloads identified where this has been
> a problem, so I'm curious why this was seen as globally an issue on
> s390. The expectation was to use __uninitialized on any variables where
> this was noticed as a performance issue, and where the memory safety of
> the variable could be proven. Turning it off by default seems like
> rather too much, but perhaps there is something unique to s390 I don't
> know about. :)

This was the result of some micro benchmarks being reported "too slow".
Actually our syscall entry/exit path got naturally slower since we switched
to generic entry; now we are trying to improve things a bit again.

There is also this RFC from Sven, which tries to inline some of the
generic system call functions, in order to avoid function calls:
https://lore.kernel.org/lkml/20230516133810.171487-1-svens@linux.ibm.com/

I stumbled upon CONFIG_INIT_STACK_NONE only by accident when wondering why
the compiler would generate quite some instructions which aren't necessary,
just to zero variables. For the getpid() system call this makes a runtime
difference of ~3%, which is quite a bit.

What is the overhead on other architectures?

That said: I was also unaware of __uninitialized. But on the other hand,
there is no sign of __uninitialized in the kernel, nor could I find
anything that could match in compiler_attributes.h.
Am I missing something here?

Thanks for bringing this up, I guess if there is some annotation available,
we can revisit at least the architecture specific entry code, and maybe
figure out how to avoid most of the extra runtime, but still keep the
feature enabled.

(Adding Sven, since I will be offline the next two weeks).
