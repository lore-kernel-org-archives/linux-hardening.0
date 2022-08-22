Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A804C32792
	for <linux-hardening@archiver.kernel.org>; Mon, 22 Aug 2022 23:15:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238346AbiHVXPk (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 22 Aug 2022 19:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232437AbiHVXPj (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 22 Aug 2022 19:15:39 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F683DBFB
        for <linux-hardening@vger.kernel.org>; Mon, 22 Aug 2022 16:15:37 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id ce26so8466249ejb.11
        for <linux-hardening@vger.kernel.org>; Mon, 22 Aug 2022 16:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=8E+K6gykmt5HP8xbcrfszwAPbr68WHWZ89nSZ7TLGjA=;
        b=qQnH48Vg2mr9fAr6mdHfAYhM67mDLLqJNlyCn5vge8mrX+oJjFhDF2v+vwxActNKqi
         j1D1/8cPTn1/cYP/wQnMVTK/U66s/XKvGBKMz0J72UxY5wy5N0ztLhY/b9tCWvooVVdA
         jEhbXPGc8R0i2p8beRGuL6/Q1vIyvNUj0q7XyAIc78BlAtZrmnjvKHI39oXPObYBdcQu
         wNgh0yvCI4xv2gve5JAJX0e66YbxjCTN01m347a6mOwAjkFjfTrDLR/DMOL8c9zTxzLu
         8vHnfIh/ylawpqKoY2PzbIqFDTdyES2EQAX7Ol0XCyd+DvRXlGcDkBftSSxqIoxWQx3B
         ghJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=8E+K6gykmt5HP8xbcrfszwAPbr68WHWZ89nSZ7TLGjA=;
        b=z9wlYFXfXWIk6DrA+xf9aQZxdlf9YR/u0qLoBNJbpefzB5Ben16nc+MrLgHKrNSD4P
         LwT8Ymb9qEatmxfiBLJhRnwNOQ62p96MEWSFJhtLAG+bOOz0Iu9FS2AZ4uBdZthz08ML
         xfdUboc+kK5fHO1WZ2t179gvMI1fltmqbUKikqMw1nIsvatR+t+/s0IFs2bQyEpZ5J3N
         mEe7BJ5zbCfxgqLZOR2wXFduQ6emBgtussEGedDvPhaYJWMUL3CVRROiPoQEo2pTN1SK
         /8z9wUJgPf3Cg7gbd+lneD6qMua7nCk/95qnjp4Lf6KkaC9K9ZvGI2jqPvQXgxL18KOJ
         iFtQ==
X-Gm-Message-State: ACgBeo1k6vfc7cLVdS6RqAYKxmcbfASQRK3aR1ciORsYe4s96g9m4lVL
        q/Q5uAh3o2TmyJ7mUcjmH6WBQcqR+JBqTBtG6kywNA==
X-Google-Smtp-Source: AA6agR4JjnExpRv4n1eMrsmIhVFafos2xFR3ioo2FP/EbwS6COrjicjMxE6HQPBIngZa6LV8TiXhRU83ZloWX1Tellw=
X-Received: by 2002:a17:907:6e9f:b0:73d:8c60:9ec5 with SMTP id
 sh31-20020a1709076e9f00b0073d8c609ec5mr2875419ejc.542.1661210136172; Mon, 22
 Aug 2022 16:15:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220819053234.241501-1-tales.aparecida@gmail.com>
 <20220819053234.241501-8-tales.aparecida@gmail.com> <CAGS_qxoVuRPF39kcVBWGuhnmaixfLAkPN6HaDRyuXmDHqmWPXg@mail.gmail.com>
 <CAGVoLp6CQO=Vw20GYYoYUEZr4BJM5FS8H8Fi3TgS0aXWVie4Lg@mail.gmail.com>
 <CAGS_qxrGVHWiEQz5b+zWz0JYmUwxnsVaoa_8SYOxb7nsRZ=iSw@mail.gmail.com> <CAGVoLp5zv5CR_Jo-dboaYF+7_8whV=rvfJHRGeVhNRTn6LzMoA@mail.gmail.com>
In-Reply-To: <CAGVoLp5zv5CR_Jo-dboaYF+7_8whV=rvfJHRGeVhNRTn6LzMoA@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Mon, 22 Aug 2022 16:15:24 -0700
Message-ID: <CAGS_qxqeJAMVBif0RVHZd=aiZZNm_io_LK4F3=bxUMa=Kkop1A@mail.gmail.com>
Subject: Re: [PATCH 7/8] lib: overflow: update reference to kunit-tool
To:     Tales <tales.aparecida@gmail.com>
Cc:     Sadiya Kazi <sadiyakazi@google.com>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        linux-doc@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, David Gow <davidgow@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Trevor Woerner <twoerner@gmail.com>, siqueirajordao@riseup.net,
        Melissa Wen <mwen@igalia.com>,
        =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@riseup.net>,
        =?UTF-8?B?TWHDrXJhIENhbmFs?= <mairacanal@riseup.net>,
        Isabella Basso <isabbasso@riseup.net>,
        Magali Lemes <magalilemes00@gmail.com>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Aug 22, 2022 at 4:12 PM Tales <tales.aparecida@gmail.com> wrote:
>
> I can bring your patches in my V3, if you don't mind! :D

Sounds good to me!
Thanks a lot for picking this up.

Daniel
