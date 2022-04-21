Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B85C433EF
	for <linux-hardening@archiver.kernel.org>; Thu, 21 Apr 2022 16:24:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbiDUQ13 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 21 Apr 2022 12:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390578AbiDUQNq (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 21 Apr 2022 12:13:46 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E071A2B241
        for <linux-hardening@vger.kernel.org>; Thu, 21 Apr 2022 09:10:54 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id bf11so6359069ljb.7
        for <linux-hardening@vger.kernel.org>; Thu, 21 Apr 2022 09:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eMQI1rEiKnusZB415KCgTRyB4BP2JkpCOZ5UBRv9+2E=;
        b=f1mereyCYHXjPh8nr0o+NjPZ4hXeoK1yRpk3KiyfgkGzBpbTRBcX8emLC6FZdsVZDf
         rUdA58HHwqNqvkoajT1ACXwK+ClfcX9oae/fKbGBG7ZIJDeHpz/ShFS5+8IwhOWVtc9e
         kWuk/nBRifTouLIu2MCAugIB+i6BGTPmk2EME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eMQI1rEiKnusZB415KCgTRyB4BP2JkpCOZ5UBRv9+2E=;
        b=QfeQ0xRGpBscXhYH8FKVvfwt4Tfn3UmlFKewy817wTGiyx28o5nrh7lie/7ODuWRNX
         nMjalHnOZ38sE8Y9uJUs+vCjLM5qPK0KE9NPhUt+m2NMneDENuU8aOP+LhH3/3+MpcoH
         UR7zeycaSNEPLVO7jZaWhI423mblJ5Ar51FF7WUqz1wO2yPZAqJLHT1IzJ6o5NgbD6XB
         IcjILkPuR41VH1zaEflIr/2haSxtvTGsWmmpqZZjCLGzGJQ8DSwHBiBwrPa1ci3cv/HG
         FlVNv8cz6c7M8M0Vp8By1smvV7GNvV7aUHu/IlQejrWAvboTnxMUZMYXGw7hKRhdHHoi
         GdlA==
X-Gm-Message-State: AOAM530QyZwBIzpwyXelQxW0dl1qC1uwuCVB8uVnCY92CBnw+avIJTIJ
        RbvoGQi5Rx1BGI9ibwdqTzpCNPVLNnZ76aAPK3M=
X-Google-Smtp-Source: ABdhPJxhqIDH2sm7pezjdSaerF61W68zFZ/2wMHFq7KHnn9tGiR9qzVPdA0vw1qXdBlPfN6618QRtA==
X-Received: by 2002:a2e:b88b:0:b0:24d:b624:6907 with SMTP id r11-20020a2eb88b000000b0024db6246907mr276753ljp.306.1650557452648;
        Thu, 21 Apr 2022 09:10:52 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id x8-20020a05651c104800b0024dbb8326b2sm1261559ljm.1.2022.04.21.09.10.50
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Apr 2022 09:10:51 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id w1so9563170lfa.4
        for <linux-hardening@vger.kernel.org>; Thu, 21 Apr 2022 09:10:50 -0700 (PDT)
X-Received: by 2002:a05:6512:108b:b0:470:90b9:fb51 with SMTP id
 j11-20020a056512108b00b0047090b9fb51mr175297lfg.52.1650557450232; Thu, 21 Apr
 2022 09:10:50 -0700 (PDT)
MIME-Version: 1.0
References: <yt9dzgkelelc.fsf@linux.ibm.com>
In-Reply-To: <yt9dzgkelelc.fsf@linux.ibm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 21 Apr 2022 09:10:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgv4NLtEowsmX+0jq_nBWXFp8jtruX6U3SDm52N=ftkgg@mail.gmail.com>
Message-ID: <CAHk-=wgv4NLtEowsmX+0jq_nBWXFp8jtruX6U3SDm52N=ftkgg@mail.gmail.com>
Subject: Re: -Warray-bounds fun again
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org, krebbel@linux.ibm.com,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Apr 21, 2022 at 7:02 AM Sven Schnelle <svens@linux.ibm.com> wrote:
>
> The obvious 'fix' is to use absolute_pointer():
>
> #define S390_lowcore (*((struct lowcore *)absolute_pointer(0)))
>
> That makes the warning go away, but unfortunately the compiler no longer
> knows that the memory access is fitting into a load/store with a 12 bit
> displacement.

In the gcc bugzilla for us needing to do these games:

    https://gcc.gnu.org/bugzilla/show_bug.cgi?id=99578

one of the suggestions was "I recommend suppressing the warning either
by #pragma GCC diagnostic or by making the pointer volatile".

But READ_ONCE() should already be doing that volatile thing, so that
suggestion may not work with gcc-12 any more.

It is *possible* that gcc-12 has now special-cased the very special
issue of a cast of the constant zero. That is how NULL was
traditionally defined.

So just out of a perverse curiosity, what happens if you do something like this:

   #define S390_lowcore_end ((struct lowcore *)sizeof(struct lowcore))
   #define S390_lowcore (S390_lowcore_end[-1])

instead? It should get the same value in the end, but it doesn't have
that special case of "cast an integer constant 0 to a pointer".

I suspect it probably doesn't help, because gcc will still see "oh,
you're basing this off address zero".

Another thing to try might be to remove the initial 16 bytes of
padding from 'struct lowcore' (it looks like the first 20 bytes are
not used - so leave 4 bytes of padding still), and use

   #define S390_lowcore (*((struct lowcore_nopad *)16))

instead. Then gcc will never see that 0, and hopefully the "he's
accessing based off a NULL pointer" logic will go away.

Because right now, our absolute_pointer() protection against this
horrible gcc mis-feature is literally based on hiding the value from
the compiler with an inline asm, and by virtue of hiding the value
then yes, gcc will have to go through a register base pointer and
cannot see that it fits in 12 bits.

.. or you just need to disable -Warray-bounds on s390.

              Linus
