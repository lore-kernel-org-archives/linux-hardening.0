Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC38EEB64D7
	for <linux-hardening@archiver.kernel.org>; Tue, 13 Jun 2023 20:26:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbjFMU07 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 13 Jun 2023 16:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbjFMU05 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 13 Jun 2023 16:26:57 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92BF61BC7
        for <linux-hardening@vger.kernel.org>; Tue, 13 Jun 2023 13:26:55 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-650bacd6250so4624625b3a.2
        for <linux-hardening@vger.kernel.org>; Tue, 13 Jun 2023 13:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686688015; x=1689280015;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MnlFW0kd0Y84IfhvBXl3XnXnVsubhiNgScvuLZLkXZY=;
        b=eu5Fl0EsFg77AB7lt65Txl0r6hk9Wb2IzCYKpbHX17N7W/zY4Hj+8zbZvi3X4kjDF9
         gQ7AtYkCRyv1seyCnxYizI7b+zkOr6wdbzQGGM2NI3b9e4D1vcOjBfDKjgGgRGVQ9L5f
         nXIR+w0GCmjhMwkeSrG0TTQkcQNUBEr/zDmrE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686688015; x=1689280015;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MnlFW0kd0Y84IfhvBXl3XnXnVsubhiNgScvuLZLkXZY=;
        b=WXGnde9+Fvog8xvINVpePq+Y0EGI7ziwuL94chA8SlHVAi/KQUB9AUJBUf9gma4cQp
         b5+mCQcwXLlQDS4HW46nh5wYt3oiGLv/v3Kl+aHVgZaYJAdriIIc7Hl53sGN2mZ/u5zK
         YCd+CWEiONil6WpTFJbXo5HYHsGX/MLtzu6x2j21JS3/o+/5lZHgUa3XKg/u7+cbeMVW
         CG3FYB7ySyduKrPbPEFgpMpstYxf3K+fBVjD7QUQyvfGTcbGGkmf13NF20T4slgeBdHE
         K/9B5k78IjkednIOZHl8fu0f7c/ZkfSYuTONzHw5ccHpmxTuI4l1t/BCDniwMjvgZ5i3
         TFlg==
X-Gm-Message-State: AC+VfDyTMn/oQLRamOzLF78Pcz9azwkOLbAIuSUIcF/BWOq+Ptof0MCC
        357h4QMWMGUIWKJtXHgutIdeuQ==
X-Google-Smtp-Source: ACHHUZ7ey7QxrIE5aHkLsg7FKb1+58NQaGZB35HpoSVqVkMJMNUaI1Tt/kaloGUkLfAEWY1BsJy2mA==
X-Received: by 2002:a05:6a20:7da8:b0:117:1c52:ba7c with SMTP id v40-20020a056a207da800b001171c52ba7cmr15082251pzj.6.1686688015095;
        Tue, 13 Jun 2023 13:26:55 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id bc1-20020a170902930100b001b392bf9192sm7647778plb.145.2023.06.13.13.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 13:26:54 -0700 (PDT)
Date:   Tue, 13 Jun 2023 13:26:53 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Rae Moar <rmoar@google.com>
Cc:     shuah@kernel.org, davidgow@google.com, dlatypov@google.com,
        brendan.higgins@linux.dev, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, jstultz@google.com,
        tglx@linutronix.de, sboyd@kernel.org
Subject: Re: [RFC v1 3/6] kunit: Add ability to filter attributes
Message-ID: <202306131324.5B69ABC@keescook>
References: <20230610005149.1145665-1-rmoar@google.com>
 <20230610005149.1145665-4-rmoar@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230610005149.1145665-4-rmoar@google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sat, Jun 10, 2023 at 12:51:46AM +0000, Rae Moar wrote:
> Add filtering of test attributes. Users can filter tests using a
> module_param_array called "filter". This functionality will be added to
> kunit.py in the next patch.
> 
> The filters will be imputed in the format:
> "<attribute_name><operation><attribute_value>"
> 
> Example: "speed>slow"
> 
> Operations include: >, <, >=, <=, !=, and =. These operations do not need
> to act the same for every attribute.

How is the "default" filter specified? Is explicitly unfiltered? (i.e.
"slow" stuff will run by default?) Or should there be a default filter
of "speed<slow" for the memcpy conversion?

But yes, I'm a fan of this whole series! I would much prefer this to
having one-off CONFIGs for slow tests. :)

-- 
Kees Cook
