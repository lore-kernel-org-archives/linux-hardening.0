Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C7AC77B73
	for <linux-hardening@archiver.kernel.org>; Tue, 30 May 2023 06:44:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjE3GoZ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 30 May 2023 02:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjE3GoY (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 30 May 2023 02:44:24 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F87E5
        for <linux-hardening@vger.kernel.org>; Mon, 29 May 2023 23:44:21 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34U6i7t4006189;
        Tue, 30 May 2023 06:44:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : content-type :
 mime-version; s=pp1; bh=1VJr5UdTDB51A0nQcs2qtFPfZtoTUX3XnI6AnTdjSeU=;
 b=F2aSriN0B9XikM2qx5g96GvE24u2tbDd63eL+TyXppyL8hP6/le2xH0z9pyHpH2s9zcG
 sz55VMX7NAoww5haI9Mi5L3YHuxCEoBIlP6MGDa6VE8g6VO1N7bySuQD6GiQhIIyTzOh
 8FRGU12B8EDps4DBuLgbcDsTDRolVkAgeZrVC2TJuYSsi2SIq6Ta/83bzblah+TdARH4
 TIt/4i2F5HaXIdhSEkuE/iEa4k1EddP0avY/GeBJI1eo1y+2su9b4hgpMIW3N/Txmric
 hneQm747WthrPxuZA30z5+ySb+NpTPkTxziYVn38gvTlz0ualfsRZfTybpCXTZh0z40Q 6A== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qwc4qg04r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 May 2023 06:44:19 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34U3UTJH029244;
        Tue, 30 May 2023 06:44:17 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3qu9g51aef-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 May 2023 06:44:17 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34U6iEEq13435464
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 May 2023 06:44:14 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 069132004B;
        Tue, 30 May 2023 06:44:14 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D021620040;
        Tue, 30 May 2023 06:44:13 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Tue, 30 May 2023 06:44:13 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-hardening@vger.kernel.org
Subject: Re: s390/defconfigs: set CONFIG_INIT_STACK_NONE=y
References: <ZG+rogQJO+U3kS4a@outflux.net> <ZHC3YJ3FHwYxYrMG@osiris>
        <202305260922.F98F90290@keescook>
Date:   Tue, 30 May 2023 08:44:13 +0200
In-Reply-To: <202305260922.F98F90290@keescook> (Kees Cook's message of "Fri,
        26 May 2023 09:37:16 -0700")
Message-ID: <yt9dy1l6mi82.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: E3tETYDOvWDRIEzv5XJwQ6n7emqT1oxl
X-Proofpoint-GUID: E3tETYDOvWDRIEzv5XJwQ6n7emqT1oxl
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_04,2023-05-29_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 clxscore=1011 malwarescore=0 phishscore=0 spamscore=0
 suspectscore=0 priorityscore=1501 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305300053
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi Kees,

Kees Cook <keescook@chromium.org> writes:

> On Fri, May 26, 2023 at 03:42:56PM +0200, Heiko Carstens wrote:
>> Hi Kees,
>> 
>> > I had this[1] patch pointed out to me, but I couldn't find any discussion
>> > about it on public lists. Can you give me some background on this? There
>> > haven't been any general workloads identified where this has been
>> > a problem, so I'm curious why this was seen as globally an issue on
>> > s390. The expectation was to use __uninitialized on any variables where
>> > this was noticed as a performance issue, and where the memory safety of
>> > the variable could be proven. Turning it off by default seems like
>> > rather too much, but perhaps there is something unique to s390 I don't
>> > know about. :)
>> 
>> This was the result of some micro benchmarks being reported "too slow".
>> Actually our syscall entry/exit path got naturally slower since we switched
>> to generic entry; now we are trying to improve things a bit again.
>> 
>> There is also this RFC from Sven, which tries to inline some of the
>> generic system call functions, in order to avoid function calls:
>> https://lore.kernel.org/lkml/20230516133810.171487-1-svens@linux.ibm.com/
>> 
>> I stumbled upon CONFIG_INIT_STACK_NONE only by accident when wondering why
>> the compiler would generate quite some instructions which aren't necessary,
>> just to zero variables. For the getpid() system call this makes a runtime
>> difference of ~3%, which is quite a bit.
>
> Hm, that does seem high. It implies there are large variable that are
> being passed by reference, perhaps in the syscall path? I had similar
> problems a while back on x86 but due to stack-protector seeing the
> register arrays and thinking they needed protection. I had to explicitly
> turn that off for the entry code, since they're provably safe. :)

From looking at our s390 specific entry code i don't see big arrays on
the stack, but let me do some profiling. Maybe i missed something.

Regards,
Sven
