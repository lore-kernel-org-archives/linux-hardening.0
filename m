Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 049A3C7618D
	for <linux-hardening@archiver.kernel.org>; Thu,  6 Apr 2023 03:15:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235061AbjDFDPU (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 5 Apr 2023 23:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235115AbjDFDPP (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 5 Apr 2023 23:15:15 -0400
X-Greylist: delayed 139 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 05 Apr 2023 20:15:07 PDT
Received: from smtp.outflux.net (mta.outflux.net [IPv6:2001:19d0:2:6:c0de:0:736d:7471])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B097EEF;
        Wed,  5 Apr 2023 20:15:06 -0700 (PDT)
Received: from auth (localhost [127.0.0.1]) (authenticated bits=0)
        by vinyl.outflux.net (8.15.2/8.15.2/Debian-10) with ESMTPSA id 3363AHIU030078
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 5 Apr 2023 20:10:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=outflux.net;
        s=2016010; t=1680750617;
        bh=Pe74VMnRV20BuyTdq7hkWWtRcm3dXjJIjDpuFrKZ4JU=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=YGPOZw9vtSSE5jPwGaH/yNy7G26n9knoZOABBe92QWjYJRc4jQQlR+bRtBrzpAl0w
         L4CvSsAu7jLHgs+g9oo4K1TRJ9qP7lQlU1a4eZ7LYYmgu6tGYhuzoYJsCzr7+jnXF3
         rOQxwr9HikYhgg4yAUJ4nSJVmEMafjlSC2BmwxbQ=
Date:   Wed, 05 Apr 2023 20:10:17 -0700
From:   Kees Cook <kees@outflux.net>
To:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org
CC:     Andy Shevchenko <andy@kernel.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Puyou Lu <puyou.lu@gmail.com>, Mark Brown <broonie@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Yury Norov <yury.norov@gmail.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Sander Vanheule <sander@svanheule.net>,
        Eric Biggers <ebiggers@google.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniel Latypov <dlatypov@google.com>,
        =?ISO-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com
Subject: Re: [PATCH 1/9] kunit: tool: Enable CONFIG_FORTIFY_SOURCE under UML
User-Agent: K-9 Mail for Android
In-Reply-To: <20230406000212.3442647-1-keescook@chromium.org>
References: <20230405235832.never.487-kees@kernel.org> <20230406000212.3442647-1-keescook@chromium.org>
Message-ID: <63B5793C-50B2-4FDB-A562-8476F7103A66@outflux.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-MIMEDefang-Filter: outflux$Revision: 1.316 $
X-HELO: [127.0.0.1]
Envelope-To: kunit-dev@googlegroups.com
Envelope-To: linux-kernel@vger.kernel.org
Envelope-To: jose.exposito89@gmail.com
Envelope-To: dlatypov@google.com
Envelope-To: linus.walleij@linaro.org
Envelope-To: andreyknvl@gmail.com
Envelope-To: mhiramat@kernel.org
Envelope-To: ebiggers@google.com
Envelope-To: sander@svanheule.net
Envelope-To: Jason@zx2c4.com
Envelope-To: yury.norov@gmail.com
Envelope-To: linux@rasmusvillemoes.dk
Envelope-To: dan.j.williams@intel.com
Envelope-To: vbabka@suse.cz
Envelope-To: liam.howlett@oracle.com
Envelope-To: ndesaulniers@google.com
Envelope-To: ojeda@kernel.org
Envelope-To: geert+renesas@glider.be
Envelope-To: rdunlap@infradead.org
Envelope-To: zhaoyang.huang@unisoc.com
Envelope-To: glider@google.com
Envelope-To: nathan@kernel.org
Envelope-To: akpm@linux-foundation.org
Envelope-To: davidgow@google.com
Envelope-To: brendan.higgins@linux.dev
Envelope-To: peterz@infradead.org
Envelope-To: jpoimboe@kernel.org
Envelope-To: broonie@kernel.org
Envelope-To: puyou.lu@gmail.com
Envelope-To: cezary.rojewski@intel.com
Envelope-To: andy@kernel.org
Envelope-To: linux-hardening@vger.kernel.org
Envelope-To: keescook@chromium.org
X-Scanned-By: MIMEDefang 2.83
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org



On April 5, 2023 5:02:00 PM PDT, Kees Cook <keescook@chromium=2Eorg> wrote=
:
>From: Kees Cook <kees@outflux=2Enet>

Hah oops=2E Wrong From/SoB=2E That's what I get for writing this on a plan=
e=2E


--=20
Kees Cook
