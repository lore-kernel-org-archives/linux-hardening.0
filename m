Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F43C433F5
	for <linux-hardening@archiver.kernel.org>; Wed, 24 Nov 2021 00:08:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240296AbhKXALn (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 23 Nov 2021 19:11:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbhKXALm (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 23 Nov 2021 19:11:42 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD91C061574;
        Tue, 23 Nov 2021 16:08:33 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4HzLvJ1tJgz4xcK;
        Wed, 24 Nov 2021 11:08:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1637712511;
        bh=b+NrS7PSaK12qZPeCb8kmME984XWQTgUeWmP6maiS1U=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=n2vjb7SM5nHA0GSsrLq9HxPEACt5ncS6LaVn5+urRDVD2kHVMG7T1iGcCTTt+//3b
         D6Q1R2KsmGqmyjgyngpQ+bzqC6eR8SYTGM3YnYchp1ZBKt0hQUSbyrKOzGjUmb6+cz
         Pu2OnyuxREQ7omDKIB8ExvyipPAl21W63E7cxSgLNnYxD2xZiZG69FX8LjQN8cMI3s
         eY1HRsKOhRYddptzHjctNEx92inw14ObI8OjNQKiZqozjQKZrD5l6UQTjf35+OsedJ
         QZoFlcTMOzNuPtXZDnk5ZvK+p1YiK7EdQNwq3TWu9NFExVAjuzkRCqrmUE3gtMTAUO
         i9Bnllv5IiW3A==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Kees Cook <keescook@chromium.org>
Cc:     LEROY Christophe <christophe.leroy@csgroup.eu>,
        kernel test robot <lkp@intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH] powerpc/signal32: Use struct_group() to zero spe regs
In-Reply-To: <202111221247.B385EA2A8@keescook>
References: <20211118203604.1288379-1-keescook@chromium.org>
 <1e312cbd-cd52-ddce-f839-db765173c526@csgroup.eu>
 <87ilwkrbhz.fsf@mpe.ellerman.id.au> <202111221247.B385EA2A8@keescook>
Date:   Wed, 24 Nov 2021 11:08:25 +1100
Message-ID: <8735nmquti.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:
> On Mon, Nov 22, 2021 at 04:43:36PM +1100, Michael Ellerman wrote:
>> LEROY Christophe <christophe.leroy@csgroup.eu> writes:
>> > Le 18/11/2021 =C3=A0 21:36, Kees Cook a =C3=A9crit=C2=A0:
>> >> In preparation for FORTIFY_SOURCE performing compile-time and run-time
>> >> field bounds checking for memset(), avoid intentionally writing across
>> >> neighboring fields.
>> >>=20
>> >> Add a struct_group() for the spe registers so that memset() can corre=
ctly reason
>> >> about the size:
>> >>=20
>> >>     In function 'fortify_memset_chk',
>> >>         inlined from 'restore_user_regs.part.0' at arch/powerpc/kerne=
l/signal_32.c:539:3:
>> >>     >> include/linux/fortify-string.h:195:4: error: call to '__write_=
overflow_field' declared with attribute warning: detected write beyond size=
 of field (1st parameter); maybe use struct_group()? [-Werror=3Dattribute-w=
arning]
>> >>       195 |    __write_overflow_field();
>> >>           |    ^~~~~~~~~~~~~~~~~~~~~~~~
>> >>=20
>> >> Reported-by: kernel test robot <lkp@intel.com>
>> >> Signed-off-by: Kees Cook <keescook@chromium.org>
>> >
>> > Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>>=20
>> Acked-by: Michael Ellerman <mpe@ellerman.id.au>
>
> Thanks! Should I take this via my tree, or do you want to take it via
> ppc?

I don't mind. If it's easier for you to take it as part of an existing
series then do that, otherwise I can pick it up.

cheers
