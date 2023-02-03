Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 716DFC636D6
	for <linux-hardening@archiver.kernel.org>; Fri,  3 Feb 2023 17:55:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233437AbjBCRzH (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 3 Feb 2023 12:55:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233221AbjBCRzE (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 3 Feb 2023 12:55:04 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA76AD32A
        for <linux-hardening@vger.kernel.org>; Fri,  3 Feb 2023 09:54:45 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id h9so5986214plf.9
        for <linux-hardening@vger.kernel.org>; Fri, 03 Feb 2023 09:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2zabOkk8raGucj5VBxNY2tARuoOEYzucUnuxzxeg5Ek=;
        b=e2zuiUIvvKN3Gi+i2FXmXzqNNZNed6qIioC591AO051BLb5lFWdx5GvErKtXMfoArh
         VIobYDCEk+RoXMVrGxIbfaRh3SGu5KdEXkVUL9IF1qgx942TVYCJAJ3hQSDwq4Im+YSn
         Rfa3ZWZamyNDaMSGLuskNYBrisL1lTsVgJxTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2zabOkk8raGucj5VBxNY2tARuoOEYzucUnuxzxeg5Ek=;
        b=SRbWYz975tz42hH3ZKAyzkNkfbpmivCnQhJq5LvnFKCQcicnXybbbfg5QwWWoQYTHy
         7pj7IlFWw0p8aMvAHO8CnxuGxcAapFLjcRAN1nMKsZflQtUd7M1ROeeCKEsyki1rEcqM
         c4pAf8wRIWMd/FnsB73M5OYDQTGo6Z7HkM4qyUWVCP5Pq5Gc+mIftyKxmczA8g5QSY1s
         Tyg5YK/CKV5nCh85e7fCNckYkCHtKncKldy2jR8YinnrMgIdFgrrtMV4+i2kb73Z1ifx
         5PX3Wsg6IgRIu0/XoPA99qtOxiwWhlNyn0GrQTi3NJgOgXLze6NznWP4krrw2WCYYTSg
         WguQ==
X-Gm-Message-State: AO0yUKWOjk8+iIb1WtTHBA6nh602NsH1kh6F6+4UPZfxk/LooLy5SUb0
        BmkkNWyCCszT90iRy5iwuNM/gg==
X-Google-Smtp-Source: AK7set9Viy6W3uH/z/gbYqjrgi1gVp1ihje8JI5TqGFl4yIwnNVl2yutLYH7E5beN1qh+gMX/raRpg==
X-Received: by 2002:a05:6a20:bb0a:b0:9d:efc0:92 with SMTP id fc10-20020a056a20bb0a00b0009defc00092mr11439154pzb.58.1675446885466;
        Fri, 03 Feb 2023 09:54:45 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d9-20020a63a709000000b004b1b9e23790sm1682499pgf.92.2023.02.03.09.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 09:54:45 -0800 (PST)
Message-ID: <63dd4a65.630a0220.e5739.3450@mx.google.com>
X-Google-Original-Message-ID: <202302031754.@keescook>
Date:   Fri, 3 Feb 2023 17:54:44 +0000
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] wifi: mwifiex: Replace one-element arrays with
 flexible-array members
References: <Y9xkECG3uTZ6T1dN@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9xkECG3uTZ6T1dN@work>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Feb 02, 2023 at 07:32:00PM -0600, Gustavo A. R. Silva wrote:
> One-element arrays are deprecated, and we are replacing them with flexible
> array members instead. So, replace one-element arrays with flexible-array
> members in multiple structures.
> 
> This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
> routines on memcpy() and help us make progress towards globally
> enabling -fstrict-flex-arrays=3 [1].
> 
> This results in no differences in binary output.
> 
> Link: https://github.com/KSPP/linux/issues/79
> Link: https://github.com/KSPP/linux/issues/256
> Link: https://gcc.gnu.org/pipermail/gcc-patches/2022-October/602902.html [1]
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
