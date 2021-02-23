Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA5D3C4332E
	for <linux-hardening@archiver.kernel.org>; Tue, 23 Feb 2021 11:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A116464E4B
	for <linux-hardening@archiver.kernel.org>; Tue, 23 Feb 2021 11:58:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbhBWL57 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 23 Feb 2021 06:57:59 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:17804 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232570AbhBWLzJ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 23 Feb 2021 06:55:09 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11NBZ7I4161707;
        Tue, 23 Feb 2021 06:54:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=C6hhHGsSYuLx59MIo/P3YZpsGYjes3e5/h8fmrfLkkQ=;
 b=UwR4pYDxkjzTeYmK99HuxduXpUKrzKOK8PbHqVGq4ps/lNNTPdnd8i29cQoDBqvtN6F2
 P1totvxbfy7JD4DMx8UYR0OJ7FyDZh/wL4urdJaL9yd+e0EJi5Uchaew80rNs4975nRx
 3YrqC1pSF0YTP4o9rO4Ie5JR8sFA+Hfl3HKlg9EXpo0XvulyR7voJ/uBLVc/iPfMvMYI
 gX2LUih3p/BQv4vqTn2u1ah5wHOitl33l6TrkJXSr6MA+MVFOG6TI8ZIyn457BvixKl4
 bpUGEeZnvT6eud6tK2RTqFXntO8KwdQX1DvjmWKBtN3LEi9uw1Zn0N5t5D4OKAFbKTjC rA== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36vkma6tsh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Feb 2021 06:54:16 -0500
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11NBrehc014775;
        Tue, 23 Feb 2021 11:54:14 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma02fra.de.ibm.com with ESMTP id 36tt289b8a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Feb 2021 11:54:14 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11NBrxVY33685844
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Feb 2021 11:53:59 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E754211C04A;
        Tue, 23 Feb 2021 11:54:11 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 99F1611C050;
        Tue, 23 Feb 2021 11:54:11 +0000 (GMT)
Received: from osiris (unknown [9.171.40.247])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 23 Feb 2021 11:54:11 +0000 (GMT)
Date:   Tue, 23 Feb 2021 12:54:10 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH] gcc-plugins: Disable GCC_PLUGIN_CYC_COMPLEXITY for s390
Message-ID: <YDTs4vfjezu3j7rX@osiris>
References: <20210221225650.33134-1-linux@roeck-us.net>
 <YDOeI5+1H3T1ocmQ@osiris>
 <f35196cc-969f-21ef-0c38-dc6e13831fb0@roeck-us.net>
 <CAK7LNASdfvJsqq8ubpBZJ5yWPMimt=pF_GFBLTJbFytbtw8jxg@mail.gmail.com>
 <8d3de6fc-0991-9cef-d5fd-032fdbe2e85e@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d3de6fc-0991-9cef-d5fd-032fdbe2e85e@roeck-us.net>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-23_07:2021-02-23,2021-02-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 lowpriorityscore=0 mlxscore=0 clxscore=1015 mlxlogscore=974 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102230100
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Feb 22, 2021 at 08:03:31AM -0800, Guenter Roeck wrote:
> > Maybe, we can add something like CONFIG_SUPPRESS_NOISY_TESTS,
> > which is set to y by all{yes,mod}config.
> > 
> > This is self-documenting, so we do not need the '# too noisy' comment.
> > 
> > 
> > 
> > config SUPPRESS_NOISY_TESTS
> >        bool "suppress noisy test"
> > 
> > 
> > config GCC_PLUGIN_CYC_COMPLEXITY
> >         bool "Compute the cyclomatic complexity of a function" if EXPERT
> >         depends on !SUPPRESS_NOISY_TESTS
> > 
> 
> Good idea. Downside would be that it won't solve the real problem
> for s390 (which is lack of allmodconfig/allyesconfig compile test
> coverage because COMPILE_TEST isn't set anymore), but that is a
> different problem anyway, and my original patch doesn't solve
> that either.

I tried to explain why we don't want to set COMPILE_TEST for s390
anymore. It overrides architecture dependencies in Kconfig, and lots
of drivers do not set dependencies for HAS_IOMEM, HAS_DMA, and friends
correctly.
This generates constantly fallout which is irrelevant for s390 and
also for other architectures. It generates just work with close to
zero benefit. For drivers which matter for s390 we still see those
errors.

> On the other side, if that flag would be set explicitly by
> all{yes,mod}config, it would really beg for being misused. We
> might then as well add a new flag that is explicitly associated
> with all{yes,mod}config, but not with randconfig.

I think that makes most sense, probably also have a flag that is set
for randconfig.
