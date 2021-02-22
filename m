Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76AA6C433DB
	for <linux-hardening@archiver.kernel.org>; Mon, 22 Feb 2021 12:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EE4A64E24
	for <linux-hardening@archiver.kernel.org>; Mon, 22 Feb 2021 12:29:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbhBVM3a (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 22 Feb 2021 07:29:30 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:4166 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230282AbhBVM31 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 22 Feb 2021 07:29:27 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11MCOh7Z129265;
        Mon, 22 Feb 2021 07:28:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=GkuPKJiGvWLM3ySATq8gt64Y5ObBblBDwn52W4C/hf4=;
 b=EUElLiEHES5spXeeH3ymtmh2OwphJL/YDo5TnQqDnwROnKeHVjNgc9wyyKO0MShfSHsL
 OpvKFIGtW/6gd9hR8YGHbIaWCsc9ppSrYabehR21L4GQt50gCPTOevdjXXt21rRf1Aqz
 3tIpJxbrikKZr4BO8LTy1Fypqj9r3mqidZvUJ5WPhhfMaTn7pT61xEHqYdgZMWG/VfPr
 DDmmV50VjFTJhA94Jn3vVNx39pxBN9r6B+bAFdqoXhrxcRWWAkydu5kA/SyQCrXQ5gk1
 U7CpoQ/TkLUIx2CeMJ/K/DY518bhX9np6KgxGVSlyX4HX3z31YOVCAUS/TdeYw1fz/pI uA== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36vckh042b-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Feb 2021 07:28:30 -0500
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11MC2jdX017253;
        Mon, 22 Feb 2021 12:06:00 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma05fra.de.ibm.com with ESMTP id 36tt288tqc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Feb 2021 12:05:59 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11MC5vXM66322908
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Feb 2021 12:05:57 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 92E04A4055;
        Mon, 22 Feb 2021 12:05:57 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 49DB1A404D;
        Mon, 22 Feb 2021 12:05:57 +0000 (GMT)
Received: from osiris (unknown [9.171.69.228])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 22 Feb 2021 12:05:57 +0000 (GMT)
Date:   Mon, 22 Feb 2021 13:05:55 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH] gcc-plugins: Disable GCC_PLUGIN_CYC_COMPLEXITY for s390
Message-ID: <YDOeI5+1H3T1ocmQ@osiris>
References: <20210221225650.33134-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210221225650.33134-1-linux@roeck-us.net>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-22_02:2021-02-22,2021-02-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 bulkscore=0 spamscore=0 priorityscore=1501 suspectscore=0 mlxscore=0
 phishscore=0 lowpriorityscore=0 mlxlogscore=999 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102220113
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sun, Feb 21, 2021 at 02:56:50PM -0800, Guenter Roeck wrote:
> Commit 334ef6ed06fa ("init/Kconfig: make COMPILE_TEST depend on !S390") disabled
> COMPILE_TEST for s390. At the same time, "make allmodconfig/allyesconfig" for
> s390 is still supported. However, it generates thousands of compiler
> messages such as the following, making it highly impractical to run.
> 
> Cyclomatic Complexity 1 scripts/mod/devicetable-offsets.c:main
> Cyclomatic Complexity 1 scripts/mod/devicetable-offsets.c:_GLOBAL__sub_I_00100_0_main
> 
> Since GCC_PLUGIN_CYC_COMPLEXITY is primarily used for testing, disable it
> when building s390 images.
> 
> Cc: Arnd Bergmann <arnd@kernel.org>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Fixes: 334ef6ed06fa ("init/Kconfig: make COMPILE_TEST depend on !S390")
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  scripts/gcc-plugins/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/gcc-plugins/Kconfig b/scripts/gcc-plugins/Kconfig
> index ab9eb4cbe33a..5e9bb500f443 100644
> --- a/scripts/gcc-plugins/Kconfig
> +++ b/scripts/gcc-plugins/Kconfig
> @@ -21,7 +21,7 @@ if GCC_PLUGINS
>  
>  config GCC_PLUGIN_CYC_COMPLEXITY
>  	bool "Compute the cyclomatic complexity of a function" if EXPERT
> -	depends on !COMPILE_TEST	# too noisy
> +	depends on !COMPILE_TEST && !S390	# too noisy

I don't see a reason to disable this in general for s390. COMPILE_TEST
was only disabled for s390 because a lot of irrelevant configs didn't
compile and it would cause a lot of unnecessary work to fix that.

However the !COMPILE_TEST dependency here looks more like it was
misused in lack of a possibility to detect if the config was generated
with allyesconfig/allmodconfig. Maybe that could be added somehow to
Kconfig?
