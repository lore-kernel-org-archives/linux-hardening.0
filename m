Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E68C7EE2D
	for <linux-hardening@archiver.kernel.org>; Wed, 17 May 2023 10:52:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbjEQKwB (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 17 May 2023 06:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbjEQKwA (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 17 May 2023 06:52:00 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F080155AE
        for <linux-hardening@vger.kernel.org>; Wed, 17 May 2023 03:51:58 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id a1e0cc1a2514c-77d53b41485so225886241.3
        for <linux-hardening@vger.kernel.org>; Wed, 17 May 2023 03:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684320718; x=1686912718;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AsR6OUNwscL0NKUwMY5J2JHuZ/PQ7g/3tvTtjbNEn7U=;
        b=3t3GXEKoq3aCl7bHc/wtwflVXeRt1BP16iGcdZLuLk2qXtH9aptAeFQyUehAC5X8yR
         e05vmUbIj0VQcDAQ1RAjvdtmIrdXl4jl1zQBPLS8x2F/3nH5pQs/As+KfToqv6Zb0Kyp
         Ss+8F5pMqzuU3X7XdZYckM1VTps5IhX/qKhWnwkVVIZm9MM2XrlnjeQtIcXKRzH/pg0j
         gtKaOjIQpI8XgSqJRZu1Fk43ojdWWkrmca67AQQbIjSHsW7L+2N+ipMtUqfHeGddi04m
         4FHsX6vkcYFQyzOqLcG3wJpYZ1gvbxrtQiV5GKfWVBgLbvE9eLBKO1iVSmCW2wgjhwVV
         NnMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684320718; x=1686912718;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AsR6OUNwscL0NKUwMY5J2JHuZ/PQ7g/3tvTtjbNEn7U=;
        b=j2SowMwhRq6K/mvCizn4HzgtUWj8piGzWojsHkQN7/hjiWhBKifMAN/EGAndTKLJE2
         9LFZzfn773i5fLyhbEJV6CjFfRzQ777okpGpkOlfmQ+g13s5s4fgO7/qbPpajHcJ6t3D
         XyNcQXEJsF0u4+cJDqKnT6Lnlq73JPryFJpFfdTB/B259gZuw2ayqUx4AV/yY2m84Ce8
         ON+lQWU88NXXfO2JydcZbFc65aYJgUPwqVtO04ghDd+kfWc5VaIxtE8XR1ZsYBnUE56w
         iFInA9BbAEUhFUF9agjgMhyZjqxgbo6wT/qVb1WRdLtPcTbVEVzJfDdfaXXzgLRaPi73
         C/aQ==
X-Gm-Message-State: AC+VfDx+27aV99kUJ+s5nvtuMZ2E9t0S6FuQ9MRhlyCZFzi8n4ZqLNyS
        dMP3VQ7u6VDyaEVhjylAT0ASV8p5yGAil9bUY8sDtADvtWVd+QhtB+2y/g==
X-Google-Smtp-Source: ACHHUZ66rJjWNZYq6nJTNc5AlzcXHzV+tCYVzjeXTglFFAJUnYEJ4O+6IgHtb+C9DuStZ08IHaLIBUE34tcTBCAklwA=
X-Received: by 2002:a67:f3cb:0:b0:434:6b92:51b1 with SMTP id
 j11-20020a67f3cb000000b004346b9251b1mr14878092vsn.16.1684320717825; Wed, 17
 May 2023 03:51:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230515130553.2311248-1-jeffxu@chromium.org> <2bcffc9f-9244-0362-2da9-ece230055320@intel.com>
 <CAEAAPHYdRyZEMp97919errF7SDuYBJoSrD5i1wrTx1sMdr_ZdQ@mail.gmail.com> <fbe53dcf-6e21-e4cf-c632-4da8369d7e83@intel.com>
In-Reply-To: <fbe53dcf-6e21-e4cf-c632-4da8369d7e83@intel.com>
From:   =?UTF-8?Q?Stephen_R=C3=B6ttger?= <sroettger@google.com>
Date:   Wed, 17 May 2023 12:51:46 +0200
Message-ID: <CAEAAPHa=zYyjV5RqvPryRsW7VqY9cJC_-CJW6HKczY0iVsy-bg@mail.gmail.com>
Subject: Re: [PATCH 0/6] Memory Mapping (VMA) protection using PKU - set 1
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     jeffxu@chromium.org, luto@kernel.org, jorgelo@chromium.org,
        keescook@chromium.org, groeck@chromium.org, jannh@google.com,
        akpm@linux-foundation.org, jeffxu@google.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000019c20605fbe17a61"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

--00000000000019c20605fbe17a61
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 17, 2023 at 12:41=E2=80=AFAM Dave Hansen <dave.hansen@intel.com=
> wrote:
>
> On 5/16/23 00:06, Stephen R=C3=B6ttger wrote:
> > On Mon, May 15, 2023 at 4:28=E2=80=AFPM Dave Hansen <dave.hansen@intel.=
com> wrote:
> >>
> >> On 5/15/23 06:05, jeffxu@chromium.org wrote:
> >>> We're using PKU for in-process isolation to enforce control-flow inte=
grity
> >>> for a JIT compiler. In our threat model, an attacker exploits a
> >>> vulnerability and has arbitrary read/write access to the whole proces=
s
> >>> space concurrently to other threads being executed. This attacker can
> >>> manipulate some arguments to syscalls from some threads.
> >>
> >> This all sounds like it hinges on the contents of PKRU in the attacker
> >> thread.
> >>
> >> Could you talk a bit about how the attacker is prevented from running
> >> WRPKRU, XRSTOR or compelling the kernel to write to PKRU like at sigre=
turn?
> >
> > (resending without html)
> >
> > Since we're using the feature for control-flow integrity, we assume
> > the control-flow is still intact at this point. I.e. the attacker
> > thread can't run arbitrary instructions.
>
> Can't run arbitrary instructions, but can make (pretty) arbitrary syscall=
s?

The threat model is that the attacker has arbitrary read/write, while other
threads run in parallel. So whenever a regular thread performs a syscall an=
d
takes a syscall argument from memory, we assume that argument can be attack=
er
controlled.
Unfortunately, the line is a bit blurry which syscalls / syscall arguments =
we
need to assume to be attacker controlled. We're trying to approach this by
roughly categorizing syscalls+args:
* how commonly used is the syscall
* do we expect the argument to be taken from writable memory
* can we restrict the syscall+args with seccomp
* how difficult is it to restrict the syscall in userspace vs kernel
* does the syscall affect our protections (e.g. change control-flow or pkey=
)

Using munmap as an example:
* it's a very common syscall (nearly every seccomp filter will allow munmap=
)
* the addr argument will come from memory
* unmapping pkey-tagged pages breaks our assumptions
* it's hard to restrict in userspace since we'd need to keep track of all
  address ranges that are unsafe to unmap and hook the syscall to perform t=
he
  validation on every call in the codebase.
* it's easy to validate in kernel with this patch

For most other syscalls, they either don't affect the control-flow, are eas=
y to
avoid and block with seccomp or we can add validation in userspace (e.g. on=
ly
install signal handlers at program startup).

> > * For JIT code, we're going to scan it for wrpkru instructions before
> > writing it to executable memory
>
> ... and XRSTOR, right?

Right. We=E2=80=99ll just have a list of allowed instructions that the JIT =
compiler can
emit.

>
> > * For regular code, we only use wrpkru around short critical sections
> > to temporarily enable write access
> >
> > Sigreturn is a separate problem that we hope to solve by adding pkey
> > support to sigaltstack
>
> What kind of support were you planning to add?

We=E2=80=99d like to allow registering pkey-tagged memory as a sigaltstack.=
 This would
allow the signal handler to run isolated from other threads. Right now, the
main reason this doesn=E2=80=99t work is that the kernel would need to chan=
ge the pkru
state before storing the register state on the stack.

> I was thinking that an attacker with arbitrary write access would wait
> until PKRU was on the userspace stack and *JUST* before the kernel
> sigreturn code restores it to write a malicious value.  It could
> presumably do this with some asynchronous mechanism so that even if
> there was only one attacker thread, it could change its own value.

I=E2=80=99m not sure I follow the details, can you give an example of an as=
ynchronous
mechanism to do this? E.g. would this be the kernel writing to the memory i=
n a
syscall for example?

> Also, the kernel side respect for PKRU is ... well ... rather weak.
> It's a best effort and if we *happen* to be in a kernel context where
> PKRU is relevant, we can try to respect PKRU.  But there are a whole
> bunch of things like get_user_pages_remote() that just plain don't have
> PKRU available and can't respect it at all.
>
> I think io_uring also greatly expanded how common "remote" access to
> process memory is.
>
> So, overall, I'm thrilled to see another potential user for pkeys.  It
> sounds like there's an actual user lined up here, which would be
> wonderful.  But, I also want to make sure we don't go to the trouble to
> build something that doesn't actually present meaningful, durable
> obstacles to an attacker.
>
> I also haven't more than glanced at the code.

--00000000000019c20605fbe17a61
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPoQYJKoZIhvcNAQcCoIIPkjCCD44CAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggz7MIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
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
2DeNJUdew/schvbvw4wolIIwTAYDVR0gBEUwQzBBBgkrBgEEAaAyASgwNDAyBggrBgEFBQcCARYm
aHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wDAYDVR0TAQH/BAIwADCBmgYI
KwYBBQUHAQEEgY0wgYowPgYIKwYBBQUHMAGGMmh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2Nh
L2dzYXRsYXNyM3NtaW1lY2EyMDIwMEgGCCsGAQUFBzAChjxodHRwOi8vc2VjdXJlLmdsb2JhbHNp
Z24uY29tL2NhY2VydC9nc2F0bGFzcjNzbWltZWNhMjAyMC5jcnQwHwYDVR0jBBgwFoAUfMwKaNei
6x4schvRzV2Vb4378mMwRgYDVR0fBD8wPTA7oDmgN4Y1aHR0cDovL2NybC5nbG9iYWxzaWduLmNv
bS9jYS9nc2F0bGFzcjNzbWltZWNhMjAyMC5jcmwwDQYJKoZIhvcNAQELBQADggEBAEWztMCBdTNW
CGPLcNM/ovJHsl+VF/BsKdiiwJoodyWO9fmhOgEVex1vfc+njM0bkWC0b4U08iUPP91eksCFGhhi
cCchsXpkAzfcKPJ7OsFd7J4xQUQPpi02r1P7Y9UKLa8nsNChf9ck1GAz1Skb77r1JWgSlHOcyuVZ
UQ/JuUVMf/XW7flFfNybswGgFmfnBvDW1qrqBPHpEFmWeNYXISpFQj0UWyGmykQGKi8q44IPy5Qg
uId+alGaBDlL5OAZQtmhRyh1MVd2wtgvGEfNGDGq603urx17nwEvM1gjSmOgnhEigOhhHH7DOeyt
5zPYLaKguxLWPGXlZ0UUjA7lH3gxggJqMIICZgIBATBoMFQxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFzIFIzIFNNSU1FIENB
IDIwMjACEAGkX4MOebzHzp8Y/d5NuOkwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIE
IKe26MzTodEX8ApXSda7lXK6EbvML4Nu13ijWG20U2XaMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0B
BwEwHAYJKoZIhvcNAQkFMQ8XDTIzMDUxNzEwNTE1OFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgB
ZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQow
CwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCuxh4kos5kFnK2j8eu
Fbrtyu6uKFJrwL1r46N5vYcVKk3Hc+GAZmfIYkGvXiN7LX4fTNyf2sEkGrpLWCteIMJL5orIuwQ3
Qotgq+Xdfb2aWXBsnXtXIwjDCgRN3JwQQnwCO8a5/YsVCuSeBIXD+vR8+Tm8/hOJo6WXoLWLn7Pc
w1cYZhoBM2ziCjC7VEvo0c/EjDHIRordEKr40+kYz9Mmid6833w6b1zxgFklbqnB1ksXhVKo7J16
5JnrMtOraFkEUFHnlZ81+5FqhqVn1f7tsI2Ww/jbuR/jSgAAEqdHShe6NoPCS8M+mEgLbVia8+6g
NUP34ZqKQKSPKpQ3lCYn
--00000000000019c20605fbe17a61--
