Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DDEDC433E0
	for <linux-hardening@archiver.kernel.org>; Fri, 19 Mar 2021 19:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DD9F6197F
	for <linux-hardening@archiver.kernel.org>; Fri, 19 Mar 2021 19:32:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbhCSTcH (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 19 Mar 2021 15:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbhCSTb7 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 19 Mar 2021 15:31:59 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F590C06174A
        for <linux-hardening@vger.kernel.org>; Fri, 19 Mar 2021 12:31:59 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id ha17so5172585pjb.2
        for <linux-hardening@vger.kernel.org>; Fri, 19 Mar 2021 12:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5opfv8LWCrrzAXi4ysTFIsG1LsWN3lMKkxUm2s4tTvA=;
        b=L5xo1THeuzMSz7uKmRd1e6xda48ErkHTSJn7EPzk9qZuCrTaI+eNvt3sC9/+0SuBK2
         smYUw8DzKPbglOs7jjXNnKp/xLDcmnFJJLRd8tupyurhoZXcEBn1PGTm91VAWGx3vMBV
         YvFUkJpm5+EGQovZOuFuvs1hUUOcjLtNNZoAw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5opfv8LWCrrzAXi4ysTFIsG1LsWN3lMKkxUm2s4tTvA=;
        b=VMbCODK99LSfd8UxzkTpno/GsOLBtWuNUne9X0adc24+ijKAGKeKnzuUiUH/v1x1Wd
         HLCIof03c82ieI3E7BeOML/pZB1wrQbP3zqHxG+w+I1JDjqqlLUrduen1eOfhp3yINfK
         /kBNCiatBcMxeGwfd2Ngz5ko3RUOkYn0gknlCPS4ISluBIKcua9Qusey1YtfoA91Nl6w
         9NwVqNl2AUFPsKdvhq1UKYUjdTflxEF5WxXkjgv+YjJih0MLcJCS/bmlYcKEMlWXQ3yf
         mWqU1CvOHp709GgtHPlg8Zrm/4WGzmD8+Tc9Bf5dctunKd1OL1HijjmHHtrEk2jl0TUZ
         YW6A==
X-Gm-Message-State: AOAM533S5ozpPp0CIjWrqQTBfyhIXhns+x7jCJcsZ30AN1LvPpbcnBXw
        vbltFrtm4J57ikIB/gonUXTGjA==
X-Google-Smtp-Source: ABdhPJydPEniMBE/5b7MpGNaruOLdPZj/mkpt8tK156nLbZZ3AD5YjtJwdB94z0VAgxiY0Yvqk3QcQ==
X-Received: by 2002:a17:902:7e4a:b029:e5:d1cf:27e4 with SMTP id a10-20020a1709027e4ab02900e5d1cf27e4mr15458775pln.69.1616182319138;
        Fri, 19 Mar 2021 12:31:59 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c25sm6007304pfo.101.2021.03.19.12.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 12:31:58 -0700 (PDT)
Date:   Fri, 19 Mar 2021 12:31:57 -0700
From:   Kees Cook <keescook@chromium.org>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     0day robot <lkp@intel.com>, LKML <linux-kernel@vger.kernel.org>,
        lkp@lists.01.org, ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@intel.com, Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
        Adam Nichols <adam@grimm-co.com>,
        linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [seq_file]  5fd6060e50:  stress-ng.eventfd.ops_per_sec -49.1%
 regression
Message-ID: <202103191230.5054A14247@keescook>
References: <20210315174851.622228-1-keescook@chromium.org>
 <20210319140742.GC30349@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319140742.GC30349@xsang-OptiPlex-9020>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Mar 19, 2021 at 10:07:42PM +0800, kernel test robot wrote:
> FYI, we noticed a -49.1% regression of stress-ng.eventfd.ops_per_sec due to commit:

Well, so it can be seen. ;) Though I feel slightly better that it's stress-ng
instead of a "normal" workload.

Thanks for the report!

-- 
Kees Cook
