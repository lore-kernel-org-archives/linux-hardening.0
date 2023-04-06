Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B670C77B6C
	for <linux-hardening@archiver.kernel.org>; Thu,  6 Apr 2023 22:50:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbjDFWuy (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 6 Apr 2023 18:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbjDFWux (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 6 Apr 2023 18:50:53 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C47A430D4
        for <linux-hardening@vger.kernel.org>; Thu,  6 Apr 2023 15:50:51 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id j14-20020a17090a7e8e00b002448c0a8813so2622203pjl.0
        for <linux-hardening@vger.kernel.org>; Thu, 06 Apr 2023 15:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680821451;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=O0msV0O5AHB0NF46Jr69g0S/BTV0Y+vyG/TkYJyeoWo=;
        b=KpaqO2Mr4cYhgn6Qnh6DVdi2arSPzn8iI1d2dKHoh6jWuL6ejpYsJmj7gu9ha09+eQ
         5ebaKDgl6gycDOa+YMUY27WT5nhNLz17ktjH9TStUMIjDtPGiWbFZc1gio/Gv/mtmsTN
         Yl7YRXuJDp3WQJGHSqn3DC+ETeLI+qMqnD/1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680821451;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O0msV0O5AHB0NF46Jr69g0S/BTV0Y+vyG/TkYJyeoWo=;
        b=ESKS/FxqNbiIwkQrEsUuVmj4SWNkx07PVWNbeDvPQ4Ups+tVSgFMDRR0BiaGk6FPqC
         4o+tu/maeFauMbqdDV7pvAcepfLDPChO9G5yZ8SU4YVblnW378IuObI61enJ+cwfTF49
         PLco8LaNoZsTKBk7zoGQSgShtKqmW34wh9H2Gy1EnbMBzHu417FESX1+iSV8x3rF/eO+
         SQTaAElUfaplGw2KXzorWlyrNcgf+qUSTSmZl9pjBzE2gh6Bhaty6HLIBoMI+Jo0pv9x
         vQlP5lCX12I00Ee0FNZtpFebDCl1xf5vQoE2hiSzu1bVdys9qFqXrja/oiHhaRedVWpU
         SvUA==
X-Gm-Message-State: AAQBX9eczSFW3F62hwj7zQ1jXlTLgUVEsByZaB0s9fG1Oemt4pzKYchG
        UN/SgZLkpGpWUqKO5SfZm9m4htGRto4yqttwbrw=
X-Google-Smtp-Source: AKy350ZpDPPfEg2CRUkH/bpwiBnQwgDuvVdD66YyvZ4O3oYBdtUxV4c5isYOpXQ5G9jXLA7UI5SP0g==
X-Received: by 2002:a17:90a:640d:b0:240:acdb:c4eb with SMTP id g13-20020a17090a640d00b00240acdbc4ebmr141177pjj.45.1680821451292;
        Thu, 06 Apr 2023 15:50:51 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id oj5-20020a17090b4d8500b0023cfdbb6496sm3660204pjb.1.2023.04.06.15.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 15:50:50 -0700 (PDT)
Message-ID: <642f4cca.170a0220.db953.9229@mx.google.com>
X-Google-Original-Message-ID: <202304061550.@keescook>
Date:   Thu, 6 Apr 2023 15:50:49 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Tony Luck <tony.luck@intel.com>,
        linux-hardening@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] pstore/ram: Convert to platform remove callback
 returning void
References: <20230401120000.2487153-1-u.kleine-koenig@pengutronix.de>
 <ee6bcb45-765b-30b8-fa38-a634b58391db@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ee6bcb45-765b-30b8-fa38-a634b58391db@igalia.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Apr 06, 2023 at 12:57:30PM -0300, Guilherme G. Piccoli wrote:
> On 01/04/2023 09:00, Uwe Kleine-König wrote:
> > The .remove() callback for a platform driver returns an int which makes
> > many driver authors wrongly assume it's possible to do error handling by
> > returning an error code. However the value returned is (mostly) ignored
> > and this typically results in resource leaks. To improve here there is a
> > quest to make the remove callback return void. In the first step of this
> > quest all drivers are converted to .remove_new() which already returns
> > void.
> > 
> > Trivially convert this driver from always returning zero in the remove
> > callback to the void returning variant.
> > 
> > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> 
> Thanks, it makes sense for me! Code-wise, it looks fine.
> 
> What would be interesting it to mention a mail thread discussing this or
> maybe the patch itself that added the .remove_new() idea
> [https://git.kernel.org/linus/5c5a7680e67b right?].
> 
> BTW, nice idea - converting all at once would be a terrible sync effort,
> I guess this way things will go smoothly.
> Feel free to add my:
> 
> Reviewed-by: Guilherme G. Piccoli <gpiccoli@igalia.com>

Thanks! Looks good to me.

Acked-by: Kees Cook <keescook@chromium.org>

Do you want to take these view some other tree, or should I take this
via my pstore tree?

-Kees

-- 
Kees Cook
