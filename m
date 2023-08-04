Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7868C001DF
	for <linux-hardening@archiver.kernel.org>; Fri,  4 Aug 2023 08:30:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbjHDIaw (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 4 Aug 2023 04:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234565AbjHDIah (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 4 Aug 2023 04:30:37 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324F1E42
        for <linux-hardening@vger.kernel.org>; Fri,  4 Aug 2023 01:30:13 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6bca5d6dcedso1575149a34.1
        for <linux-hardening@vger.kernel.org>; Fri, 04 Aug 2023 01:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691137812; x=1691742612;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sTW4GcsIoC0wedeu0cP1p/SdzNq7SXqwMejU+XlRg/A=;
        b=MvtJgYJPzaQQIT9hlilDCoYXW4oKr+21puhVNZnk9hWavc6zsfjb8FEqO4hz4fnG4K
         g/FDP6rDwriWsdbhabPq8ziSYLV6NYvIh9aE+yQ7xItRqv+b8wd1KZA7erHvLJKxqK9L
         nzkt9ue7WCYcXalaymwYDUPEpDYLeFaAWgaCY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691137812; x=1691742612;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sTW4GcsIoC0wedeu0cP1p/SdzNq7SXqwMejU+XlRg/A=;
        b=HLnHf9pNgBnhyLOdkhzsQjYoq3Ut1YRblboUZTnfDSwv26PorQoMjZTDHMWMgoY1zg
         nMq5KW8XyCY+PeGn6EkxJupUJ385GXSC+zKwkoMLPsX7nAPyNm/v9AlTRAasJfuj2XCA
         6U1pgwJ8RyopgodVcYXVjMj1O63kw8uROuIpBxJdmpd2G9Yy4KEwb3Kcri1Wab4fab+k
         pq71xRBGaNKqFckfXjYixtZQc1vNdD7NdYlnY5ptxQm5UmBAn9eZlWT8uviDiV8DKQ9z
         bBdqxykwHd1Vu7jvY02QQpaIz2Jy1MLZg30sa06tU0eYHRviU3zoZZ9D6FeJeQOk9H6H
         D1/A==
X-Gm-Message-State: AOJu0YwO81WkTYK2TIuNEAwHl0sbe1vwuoK4HCKGUClLTavQYCqSExhM
        qv6t4+GkovYEGcnn2P4XF+ibYQ==
X-Google-Smtp-Source: AGHT+IHh6wCyuLACZdpvHgsdR8UkOmQsmagdun+zvBpnhfZpwlQcNCElW7X7S0H00eHM1MYxpZV3NA==
X-Received: by 2002:a9d:67d6:0:b0:6b9:68fb:5a28 with SMTP id c22-20020a9d67d6000000b006b968fb5a28mr931396otn.27.1691137810270;
        Fri, 04 Aug 2023 01:30:10 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id o14-20020a17090a4b4e00b00268b439a0cbsm1057998pjl.23.2023.08.04.01.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 01:30:09 -0700 (PDT)
Date:   Fri, 4 Aug 2023 01:30:09 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Alexander Lobakin <aleksander.lobakin@intel.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        netdev@vger.kernel.org, linux-hardening@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 3/3] virtchnl: fix fake 1-elem arrays for
 structures allocated as `nents`
Message-ID: <202308040130.E48094967E@keescook>
References: <20230728155207.10042-1-aleksander.lobakin@intel.com>
 <20230728155207.10042-4-aleksander.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728155207.10042-4-aleksander.lobakin@intel.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Jul 28, 2023 at 05:52:07PM +0200, Alexander Lobakin wrote:
> Finally, fix 3 structures which are allocated technically correctly,
> i.e. the calculated size equals to the one that struct_size() would
> return, except for sizeof(). For &virtchnl_vlan_filter_list_v2, use
> the same approach when there are no enough space as taken previously
> for &virtchnl_vlan_filter_list, i.e. let the maximum size be calculated
> automatically instead of trying to guestimate it using maths.
> 
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
