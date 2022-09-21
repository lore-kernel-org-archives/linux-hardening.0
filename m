Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 881C2ECAAD8
	for <linux-hardening@archiver.kernel.org>; Wed, 21 Sep 2022 11:24:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbiIULYf (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 21 Sep 2022 07:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiIULYd (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 21 Sep 2022 07:24:33 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB383B3;
        Wed, 21 Sep 2022 04:24:30 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id d8so4705265iof.11;
        Wed, 21 Sep 2022 04:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=fsVCs4sBW7mt/Ih6nbdJIMUX5/GY7OGQyDYGufKtJuY=;
        b=iN0JOF+g9QGNk9LTGtdxKX8dUCLOL8R1PzDjBH+vqr/6EWFF0hOr78E/FIdwxCzCqI
         Wie6LcvFlEOy/Mks2qbbgt7X1HE7B5KfHuYeUC5mZI3rl5VyYAxwXDz6lLSVRx+f0Mmu
         znTFjjvTyefD9xpeTjUW+Y6z1YRYvV+9CEhPUNcxz126x3lQ9dx6/IepaouRgG9a+UHP
         OCSz4gs0hkBpbhp1rcH46JH5Ry6WEW65xs1Fu80gCyBLjvkR5X02sL08jhBEN2N20HJf
         FFKIIeH4y9HMYHGhWeLV4gEV3crUeCSrd8hoe5GTM3XDNaQ6JEvRdEyx+AU8uvZzx9Hq
         DnJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=fsVCs4sBW7mt/Ih6nbdJIMUX5/GY7OGQyDYGufKtJuY=;
        b=Lw29htLV+X7vxZd4gu9kek4Q6W/ZWJSHAclSkpoOv8DYePtHbjvopXHr8tht7fQ8mE
         gd1WENBqb/xQDW6UVjefe2O2mbwAxoWIAkcJRwUVpKzGkEB8maZRthqE4i4GMmxAFv+C
         u19qA31avCqLPz11fXu2vZpvPoYWvPtGU+sO0x0VRyDa69RbuLmizs+TH+gSHf6I2Was
         GXoVsBZioSR7s9htwsxzh0XSA9s2Bny/1iPHAUhcyrJtDmzVfgy8cIXqd8C2g22PlUOb
         9931IgajO0P1/eJ3X5k9KSe+A4PdBeZHbfSBpp7I98GtMiZzKrSUl4G9EmaW1R5He+Be
         N0Qg==
X-Gm-Message-State: ACrzQf20lIOENnZXmlo+oV49W3AZe+eXz0eeTnmoELqCqsKA+QfWxxvr
        b136ATT7x2L3w4Vf+xQwRv3JpOfyDvChlTF6L4ZBS5z9
X-Google-Smtp-Source: AMsMyM6uOuMdp3diWSaDOVFlUXXzn9Z7lcYdIt7nzwrMplXw4mcnKhKdpeKYa3ux/SOSGvIDD+74pDS0N6SFW8ntAlc=
X-Received: by 2002:a05:6638:144f:b0:35a:68ad:ea0e with SMTP id
 l15-20020a056638144f00b0035a68adea0emr13186136jad.199.1663759469399; Wed, 21
 Sep 2022 04:24:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220920192202.190793-1-keescook@chromium.org> <20220920192202.190793-5-keescook@chromium.org>
In-Reply-To: <20220920192202.190793-5-keescook@chromium.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 21 Sep 2022 13:24:18 +0200
Message-ID: <CANiq72n+vTg6cq3TRjJ97H_B3-Vv68itpW1+E66+Pa3zCTch6g@mail.gmail.com>
Subject: Re: [PATCH 4/4] fortify: Use __builtin_dynamic_object_size() when available
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-hardening@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Siddhesh Poyarekar <siddhesh@gotplt.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, llvm@lists.linux.dev,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Sep 20, 2022 at 9:22 PM Kees Cook <keescook@chromium.org> wrote:
>
>  include/linux/compiler_attributes.h | 5 +++++

Reviewed-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel
