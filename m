Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 644CCC6FD1D
	for <linux-hardening@archiver.kernel.org>; Fri, 17 Mar 2023 20:51:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbjCQUvk (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 17 Mar 2023 16:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjCQUvj (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 17 Mar 2023 16:51:39 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414323E08F
        for <linux-hardening@vger.kernel.org>; Fri, 17 Mar 2023 13:51:37 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id er8so13397926edb.0
        for <linux-hardening@vger.kernel.org>; Fri, 17 Mar 2023 13:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1679086295;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HGPinKOg8Q94FTw3RW1XhRjZJIhdvmuXH/yX2ELyuDQ=;
        b=d+ZPrGN7mH+n06n73UyCuuGRKEzvOIcp0CnERIXzSKexwWJXV8UGn8lyuhffqPfRge
         RTyCIpYh2JhNm6rmsEIkCp1eaacgKpnTxHswMQzZbV9/5GvKhIR8gaL4IeU2GLpf4XOO
         ZbcYBBPCXyWtan3iA+0A71ES1364NVP+weSAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679086295;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HGPinKOg8Q94FTw3RW1XhRjZJIhdvmuXH/yX2ELyuDQ=;
        b=BJKPxx43x2EgqZo2jn2UWca4m0vvldxCmvcHskh+5cVBU3RkEKDmP+Au4PBkrUh9Yn
         LRqxjiRyaPulCbivzZJmDQJPPGWDGrad0l36eEjMVkbpI2lsEHe4Tpf3md833bEx1uyB
         smbCqnSWC1fPxoXM5ot9gXWxj6nYrKknnkmdAEviYGCdaxaZn3L+xBUidV6AA9BF0y9Z
         eyNsS/2u4uLWWb8bhSvTUytX6ZWheg0+50ass4M/4KQ3kiqBxau5ai436zLmb6ZszSQT
         EwvBfGZZ7kSAzrNzFZePLyMrY9GW48D++FbdogWSAdzrIKMqEdiJW1DK66CW2uDkOPVa
         la0w==
X-Gm-Message-State: AO0yUKWB5LGKRt3z+KUJQIiEHtzK9GVq6mK6JjqD5AndrntaBjgm+721
        8h0LNJTMx4sP9PN4ztw7nlOrS9jv8+geB57datNrBA==
X-Google-Smtp-Source: AK7set9FvDwTrOaauZrCq3o3WsEAwwD3lOGhDrFOslyIdecJXcbI/vGbUcpt/x4virnHfsT294L2Ow==
X-Received: by 2002:a17:907:2bd2:b0:929:d2f4:1824 with SMTP id gv18-20020a1709072bd200b00929d2f41824mr612838ejc.21.1679086295506;
        Fri, 17 Mar 2023 13:51:35 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id wr5-20020a170907700500b008b133f9b33dsm1333457ejb.169.2023.03.17.13.51.34
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 13:51:34 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id r11so25136662edd.5
        for <linux-hardening@vger.kernel.org>; Fri, 17 Mar 2023 13:51:34 -0700 (PDT)
X-Received: by 2002:a17:906:2695:b0:931:99b5:67a4 with SMTP id
 t21-20020a170906269500b0093199b567a4mr291317ejc.15.1679086294427; Fri, 17 Mar
 2023 13:51:34 -0700 (PDT)
MIME-Version: 1.0
References: <9d0ef355-f430-e8e2-c844-b34cfcf60d88@kernel.dk>
 <CAHk-=wgcYvgJ5YWJPy6PA-B_yRtPfpw01fmCqtvqGN9jouc_8w@mail.gmail.com>
 <CAKwvOdmJkQUe6bhvQXHo0XOncdso0Kk26n8vdJZufm4Ku72tng@mail.gmail.com>
 <6414c470.a70a0220.6b62f.3f02@mx.google.com> <CAHk-=wi5yk0+NeqB34fRC-Zvt+8QZVPTiny9MvCxxjg+ZqDhKg@mail.gmail.com>
 <CANiq72m46OzQPtZbS_VaQGgGknFV-hKvhBw8sVZx9ef=AzupTQ@mail.gmail.com>
In-Reply-To: <CANiq72m46OzQPtZbS_VaQGgGknFV-hKvhBw8sVZx9ef=AzupTQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 17 Mar 2023 13:51:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgTSdKYbmB1JYM5vmHMcD9J9UZr0mn7BOYM_LudrP+Xvw@mail.gmail.com>
Message-ID: <CAHk-=wgTSdKYbmB1JYM5vmHMcD9J9UZr0mn7BOYM_LudrP+Xvw@mail.gmail.com>
Subject: Re: [GIT PULL] Block fixes for 6.3-rc3
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jens Axboe <axboe@kernel.dk>,
        Nathan Chancellor <nathan@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Mar 17, 2023 at 1:42=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> It is comparing against just the `.code` in the `m5mols_default_ffmt`
> table, i.e. the `MEDIA_BUS_FMT_VYUY8_2X8` (8199 =3D 0x2007) and
> `MEDIA_BUS_FMT_JPEG_1X8` (16385 =3D 0x4001), see

Yeah, I see what it's doing.

But:

> If the condition had `++type` instead, it would not be a problem,
> because the loop stops before we go into the out of bounds access thus
> no UB.

Yeah, but clang really should have generated a proper third iteration,
which calls that "out of bounds" case, and then returns, instead fo
falling off the end.

I do think that on the kernel side, the fix is to just change

        } while (type++ !=3D SIZE_DEFAULT_FFMT);

to

        } while (++type !=3D SIZE_DEFAULT_FFMT);

but I would *really* like clang to be fixed to not silently generate
code that does insane things and would be basically impossible to
debug if it ever triggers.

We would have spent a *lot* of time wondering how the heck we Oopsed
in m5mols_get_frame_desc().

             Linus
