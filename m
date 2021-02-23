Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF0B4C433E0
	for <linux-hardening@archiver.kernel.org>; Tue, 23 Feb 2021 18:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A172464DF3
	for <linux-hardening@archiver.kernel.org>; Tue, 23 Feb 2021 18:04:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233005AbhBWSE4 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 23 Feb 2021 13:04:56 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43300 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233011AbhBWSEz (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 23 Feb 2021 13:04:55 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11NI3xlV164988;
        Tue, 23 Feb 2021 13:04:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=CRJrQGBIMdvl8HDZ1wcqJa6CD1wYhFACnglRBNcyzLY=;
 b=DgCDU8dVV02CMzM5NJEDvClYIV2fq99ScIHFvizQr5DMwXbsAV9Ut3omI/RZvvFqdlmV
 2Vz+P7x00wkA6YnX+UoHTbi6N1fGm04+vALEkAVos2b8cnKGrlwXwqHhjtjdyd/67pju
 IumRQ3KmRRLXxyhytBvGMSJKwFS4l1jaXcFxMzBzU3aZk4cCoVyThoV+Bh9xWFKN0Tnn
 h8j7AT6J3GxfszQtVCPT018aXA2aHx+rdlifm2G3DrxLb7Um8kl4PhzSioKSI8tLAOAl
 7gcw0vtCBnJ9+fUdE4SK61Wf+4UpdQLQGefJF8Os+FnlpummUhwp+LyO+ZD6n8m4CC+5 hQ== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36vkft2pb7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Feb 2021 13:04:01 -0500
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11NI3mxJ018893;
        Tue, 23 Feb 2021 18:03:51 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma01fra.de.ibm.com with ESMTP id 36tt289fwx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Feb 2021 18:03:51 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11NI3nIC46006780
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Feb 2021 18:03:49 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 01CCE11C04C;
        Tue, 23 Feb 2021 18:03:49 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 996E511C064;
        Tue, 23 Feb 2021 18:03:48 +0000 (GMT)
Received: from osiris (unknown [9.171.75.226])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 23 Feb 2021 18:03:48 +0000 (GMT)
Date:   Tue, 23 Feb 2021 19:03:47 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH] gcc-plugins: Disable GCC_PLUGIN_CYC_COMPLEXITY for s390
Message-ID: <YDVDg/EZWjCZQn2v@osiris>
References: <20210221225650.33134-1-linux@roeck-us.net>
 <YDOeI5+1H3T1ocmQ@osiris>
 <f35196cc-969f-21ef-0c38-dc6e13831fb0@roeck-us.net>
 <CAK7LNASdfvJsqq8ubpBZJ5yWPMimt=pF_GFBLTJbFytbtw8jxg@mail.gmail.com>
 <8d3de6fc-0991-9cef-d5fd-032fdbe2e85e@roeck-us.net>
 <YDTs4vfjezu3j7rX@osiris>
 <20210223174140.GA159796@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210223174140.GA159796@roeck-us.net>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-23_08:2021-02-23,2021-02-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 mlxlogscore=997 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 spamscore=0 adultscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102230152
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Feb 23, 2021 at 09:41:40AM -0800, Guenter Roeck wrote:
> > I tried to explain why we don't want to set COMPILE_TEST for s390
> > anymore. It overrides architecture dependencies in Kconfig, and lots
> > of drivers do not set dependencies for HAS_IOMEM, HAS_DMA, and friends
> > correctly.
> > This generates constantly fallout which is irrelevant for s390 and
> > also for other architectures. It generates just work with close to
> > zero benefit. For drivers which matter for s390 we still see those
> > errors.
> > 
> > > On the other side, if that flag would be set explicitly by
> > > all{yes,mod}config, it would really beg for being misused. We
> > > might then as well add a new flag that is explicitly associated
> > > with all{yes,mod}config, but not with randconfig.
> > 
> > I think that makes most sense, probably also have a flag that is set
> > for randconfig.
> 
> Not sure what value such an option would have, and how it would be used.
> I would argue that randconfig should not set COMPILE_TEST to start with,
> since its purpose should be to test random valid configurations and not
> to compile test arbitrary (and in that case random) code. But that is
> a different question, and just my personal opinion.
> 
> Overall, the question is what kind of additional option you would find
> useful for s390. You make it clear that you don't want COMPILE_TEST.
> At the same time, you still want all{mod,yes}config, but presumably
> excluding options currently restricted by !COMPILE_TEST (such as
> DEBUG_INFO, BPF_PRELOAD, UBSAN_TRAP, GCC_PLUGIN_CYC_COMPLEXITY,
> and a few others). SUPPRESS_NOISY_TESTS would not cover that, but
> neither would RANDCONFIG (or whatever it would be called).

Well, if we would have e.g. RANDCONFIG, then we could probably revert
334ef6ed06fa ("init/Kconfig: make COMPILE_TEST depend on !S390") and
instead let COMPILE_TEST depend on !RANDCONFIG.
I think this _could_ solve all common problems we currently see.

And it would also do what you suggested.
