Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8153C5479D
	for <linux-hardening@archiver.kernel.org>; Wed, 11 Jan 2023 07:18:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234978AbjAKHS1 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 11 Jan 2023 02:18:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235733AbjAKHSW (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 11 Jan 2023 02:18:22 -0500
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33834F5A7
        for <linux-hardening@vger.kernel.org>; Tue, 10 Jan 2023 23:18:21 -0800 (PST)
Received: by mail-vs1-xe31.google.com with SMTP id 186so9517546vsz.13
        for <linux-hardening@vger.kernel.org>; Tue, 10 Jan 2023 23:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3vTUSf2GSCHZSP+yD/3e4WFCv0g/4Z+XHPSuRPbXy0E=;
        b=jrNBgsy3rhy1bEvKV9ljJdjNO48AKzIQZ5+sczSRP0QHwGzCUP9EL0bZUhuAcbiP3U
         0N/TlUyjwX61k7qLXYxM146jBRg4JUq82zyL9xbtMmAD4e1UoOT3thgfaOxRuTYoQ/jF
         RGkR41WdhUsNSTDWldgEsZ+NX5q9v9Q/HoqtaSss8iUzrRLkoTVnPmJDxuALtoLVKsXp
         Dgg2dtbTn+xL5rL9H6HZniq4Bpw0ZaOpwCFRZ8YhfAcjzT4//Y6K2BjiPq5VOs9h1fYQ
         iRSfXqMTfeEjIpfTwL7NDYC3+CPFz64BmMJ/YpADPjTeh1RJTHYQ9YM4oyQwJMi7/LHW
         vICA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3vTUSf2GSCHZSP+yD/3e4WFCv0g/4Z+XHPSuRPbXy0E=;
        b=Hod9UzWNgg6bsBnDqhRVphOj/yA/IYN4t4uWhG0UW+Zp7/fUXc2lf4J+HyFKQ0sQMm
         hOkqP69nJ8bKdoM3vU/VmvGX7hsqHV0TR0treJHUX+J2dYq4PKPHF1cy+bWsdX6bWol8
         V7YSc+/cxffZcmDJpnjoswerWeSo0h2CzItUQ8f75ZDNm5MSgj3MiAUC8tvZL0/ev/yz
         ySTM4QjDIVuhuh89PrfxdDXi80qKIbS30NclfGSV2wm8ZOkUUE63bo2p+/wni0l35pad
         LcezOWqr1Qub6/Bo+oH1XSgDtN0VAldpVAXODU4tIvQ7G3XFWsNW7hNZXrqi2JIGr/hm
         hLpw==
X-Gm-Message-State: AFqh2krI9VQHbZy7S1uQ5z3wYqrrd1JLpRhxgLH/6HEoZFHo9FuXBifV
        GrjYP8rVFt1Zhe/F7imLra/MtGAM/S92RRZs5Ho+qw==
X-Google-Smtp-Source: AMrXdXvfe05TuqDmPdD7QeQzdQJsBMn6uhWglzck6cvN+h+jjYLGL1R67I5UQLFyCGXHQnqiFDFAn6GpAT4Npl2BMuk=
X-Received: by 2002:a67:b143:0:b0:3ce:c848:a239 with SMTP id
 z3-20020a67b143000000b003cec848a239mr4212530vsl.18.1673421500253; Tue, 10 Jan
 2023 23:18:20 -0800 (PST)
MIME-Version: 1.0
References: <20230107040203.never.112-kees@kernel.org>
In-Reply-To: <20230107040203.never.112-kees@kernel.org>
From:   David Gow <davidgow@google.com>
Date:   Wed, 11 Jan 2023 15:18:08 +0800
Message-ID: <CABVgOS=ySmWfWqxra4N7z9dqWsk86GY=LTDZ2juPXAQGp462EA@mail.gmail.com>
Subject: Re: [PATCH] kunit: memcpy: Split slow memcpy tests into MEMCPY_SLOW_KUNIT_TEST
To:     Kees Cook <keescook@chromium.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-hardening@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Miguel Ojeda <ojeda@kernel.org>,
        Isabella Basso <isabbasso@riseup.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000019a98705f1f7ceaa"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

--00000000000019a98705f1f7ceaa
Content-Type: text/plain; charset="UTF-8"

On Sat, 7 Jan 2023 at 12:02, Kees Cook <keescook@chromium.org> wrote:
>
> Since the long memcpy tests may stall a system for tens of seconds
> in virtualized architecture environments, split those tests off under
> CONFIG_MEMCPY_SLOW_KUNIT_TEST so they can be separately disabled.
>
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Link: https://lore.kernel.org/lkml/20221226195206.GA2626419@roeck-us.net
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> Guenter, does this give you the needed flexibility to turn on the memcpy
> kunit tests again in your slower environments?
> ---

Sorry for the delay: I've just got back from holidays.

This looks good to me (modulo the tristate/bool issue mentioned).

Having a specific way to tag tests as "slow" is something we've
considered having in KUnit for a while, but (at least initially),
there weren't any tests slow enough for it to be worthwhile. It looks
like that's changing (alongside this, there are a few DRM tests which
are quite slow, as well as some of the KCSAN tests. Even the
time64_to_tm_test_date_range test, while very quick under UML on a
modern system, is noticeably slow under qemu and times out on
something like an old 486...). Daniel's comments elsewhere in this
thread have some good ideas.

That being said, it'll probably take long enough to work out and
implement a good way of giving tests "properties" and requesting only
fast tests run that just putting tests which are slow enough to cause
problems behind a kconfig entry seems a pretty solid intermediate
solution.

So this is:
Reviewed-by: David Gow <davidgow@google.com>

(assuming the tristate goes to bool), and I'll look into getting a way
of marking tests as "slow" and enabling/disabling them at runtime.

Cheers,
-- David

>  lib/Kconfig.debug  |  9 +++++++++
>  lib/memcpy_kunit.c | 17 +++++++++++++----
>  2 files changed, 22 insertions(+), 4 deletions(-)
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index c2c78d0e761c..b5e94807f41c 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2621,6 +2621,15 @@ config MEMCPY_KUNIT_TEST
>
>           If unsure, say N.
>
> +config MEMCPY_SLOW_KUNIT_TEST
> +       tristate "Include exhaustive memcpy tests" if !KUNIT_ALL_TESTS

As mentioned, if this is just going to be a toggle, it can be a "bool".


> +       depends on MEMCPY_KUNIT_TEST
> +       default KUNIT_ALL_TESTS
> +       help
> +         Some memcpy tests are quite exhaustive in checking for overlaps
> +         and bit ranges. These can be very slow, so they are split out
> +         as a separate config.
> +
>  config IS_SIGNED_TYPE_KUNIT_TEST
>         tristate "Test is_signed_type() macro" if !KUNIT_ALL_TESTS
>         depends on KUNIT
> diff --git a/lib/memcpy_kunit.c b/lib/memcpy_kunit.c
> index 89128551448d..cc1f36335a9b 100644
> --- a/lib/memcpy_kunit.c
> +++ b/lib/memcpy_kunit.c
> @@ -307,8 +307,12 @@ static void set_random_nonzero(struct kunit *test, u8 *byte)
>         }
>  }
>
> -static void init_large(struct kunit *test)
> +static int init_large(struct kunit *test)
>  {
> +       if (!IS_ENABLED(CONFIG_MEMCPY_SLOW_KUNIT_TEST)) {
> +               kunit_skip(test, "Slow test skipped. Enable with CONFIG_MEMCPY_SLOW_KUNIT_TEST=y");
> +               return -EBUSY;
> +       }
>
>         /* Get many bit patterns. */
>         get_random_bytes(large_src, ARRAY_SIZE(large_src));
> @@ -319,6 +323,8 @@ static void init_large(struct kunit *test)
>
>         /* Explicitly zero the entire destination. */
>         memset(large_dst, 0, ARRAY_SIZE(large_dst));
> +
> +       return 0;
>  }
>
>  /*
> @@ -327,7 +333,9 @@ static void init_large(struct kunit *test)
>   */
>  static void copy_large_test(struct kunit *test, bool use_memmove)
>  {
> -       init_large(test);
> +
> +       if (init_large(test))
> +               return;
>
>         /* Copy a growing number of non-overlapping bytes ... */
>         for (int bytes = 1; bytes <= ARRAY_SIZE(large_src); bytes++) {
> @@ -472,7 +480,8 @@ static void memmove_overlap_test(struct kunit *test)
>         static const int bytes_start = 1;
>         static const int bytes_end = ARRAY_SIZE(large_src) + 1;
>
> -       init_large(test);
> +       if (init_large(test))
> +               return;
>
>         /* Copy a growing number of overlapping bytes ... */
>         for (int bytes = bytes_start; bytes < bytes_end;
> @@ -549,8 +558,8 @@ static void strtomem_test(struct kunit *test)
>  static struct kunit_case memcpy_test_cases[] = {
>         KUNIT_CASE(memset_test),
>         KUNIT_CASE(memcpy_test),
> -       KUNIT_CASE(memcpy_large_test),
>         KUNIT_CASE(memmove_test),
> +       KUNIT_CASE(memcpy_large_test),
>         KUNIT_CASE(memmove_large_test),
>         KUNIT_CASE(memmove_overlap_test),
>         KUNIT_CASE(strtomem_test),
> --
> 2.34.1
>

--00000000000019a98705f1f7ceaa
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPnwYJKoZIhvcNAQcCoIIPkDCCD4wCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggz5MIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA3MjgwMDAwMDBaFw0yOTAzMTgwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFIzIFNNSU1FIENBIDIwMjAwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvLe9xPU9W
dpiHLAvX7kFnaFZPuJLey7LYaMO8P/xSngB9IN73mVc7YiLov12Fekdtn5kL8PjmDBEvTYmWsuQS
6VBo3vdlqqXZ0M9eMkjcKqijrmDRleudEoPDzTumwQ18VB/3I+vbN039HIaRQ5x+NHGiPHVfk6Rx
c6KAbYceyeqqfuJEcq23vhTdium/Bf5hHqYUhuJwnBQ+dAUcFndUKMJrth6lHeoifkbw2bv81zxJ
I9cvIy516+oUekqiSFGfzAqByv41OrgLV4fLGCDH3yRh1tj7EtV3l2TngqtrDLUs5R+sWIItPa/4
AJXB1Q3nGNl2tNjVpcSn0uJ7aFPbAgMBAAGjggGKMIIBhjAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFHzM
CmjXouseLHIb0c1dlW+N+/JjMB8GA1UdIwQYMBaAFI/wS3+oLkUkrk1Q+mOai97i3Ru8MHsGCCsG
AQUFBwEBBG8wbTAuBggrBgEFBQcwAYYiaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL3Jvb3Ry
MzA7BggrBgEFBQcwAoYvaHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvcm9vdC1y
My5jcnQwNgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIz
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
N0A3bgltvER3q1cGraQJMEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQAxS21FdvRtCQVc
jgEj+xxSnUr0N9reJlI5J9zRiBCWGxm5yhz965IDka3XVFEbj+beJj/gyHoxbaTGf2AjOufpcMqy
p4mtqc2l4Csudl8QeiBaOUDx4VKADbgxqpjvwD5zRpSKVj4S9y3BJi9xrRdPOm1Z2ZZYxRUxUz7d
2MXoxQsFucGJO5a4CwDBaGgJAqvwCXU5Q64rKVIUBk6mtcd3cDwX+PXqx4QrhHFGq6b6oi37YQ8B
+bhlXqlkLrbPlPFk+4Rh4EaW92iD5g8kvtXCOwvIIvs+15Io0dbpIe2W5UKo2OcyDDFvrOACmUOE
/GuEkhENcyDVyEs/4/N2u9WYMYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABj4peqtakTCOMXLZ2mEqRMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCu
AGeAG0JDwnwYBkulE38RWwNguO1W/QXihkkRDvU0rzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzAxMTEwNzE4MjBaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEABzeXhY40g7s5GO8WgU0D
O1dO4l23nVPvjdudQff9MS9tw4rS/IEOvAjoDtQMQ68S20TpGkLnry1CJwrLieT23WEURN/S6KkR
DoIyfej+JUVflTcrS2SDWxg6zyNjfMoDjN7ovg7XH6llAlXaIASOfsReA1tOF+I3nmUol6jiekxp
brxOtN1zsJdiXcBKPwMgcHzXc8f8OyP9Hv24Uz31h2I+IBKumykObF4mKxqdrxDyH1pM6DY8BJz5
58iQWe5QufZ9gcucWMOcIUHqrfzXKDkiajqt5b4b1nPust5Wn1b027Fel6L/LBSU3RNmBXJJj+3v
A18jmjf3ozz2NPElLQ==
--00000000000019a98705f1f7ceaa--
