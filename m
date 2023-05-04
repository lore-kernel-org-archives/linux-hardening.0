Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC8A5C77B75
	for <linux-hardening@archiver.kernel.org>; Thu,  4 May 2023 02:59:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjEDC7x (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 3 May 2023 22:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjEDC7w (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 3 May 2023 22:59:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FBE1A4;
        Wed,  3 May 2023 19:59:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE9BD61592;
        Thu,  4 May 2023 02:59:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C6E1C433EF;
        Thu,  4 May 2023 02:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683169190;
        bh=GireKYj/mRtD4dWjKfNVWI5ll+YC+Kxs5r5H9H/h/a4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HCGp2kkaojdjEulWXbQiUtQrMpHvGDhwhhEh1miZU4quCS9ah082GljeMizCrXz1S
         cLbyQEc1h+TOufJSL5jf+jhuPCGsi1uHpJW+QJ3te0ol0/gVdY/ipFgUKvKbGkoFj3
         clhY2lPvEljWlKV+IOapxy59rZGPQvL12kyzk0LXsWWF5jxrylY0Kuu79MSpk2Vpr+
         cjzzGm0XsQna2X5Jsjm7flHWhl7NuTNUSXqAeWXi8+QajNh5tbwurOPvNAPPiODtC8
         eC7eY5GrLXUHPq+xBrTR7wi7pICQtAK2jXhLTXTLa8O4VBKg2bnl0wHmlQYp4RwgLQ
         WsZVGDKyRZpIA==
Date:   Wed, 3 May 2023 19:59:48 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Ding Hui <dinghui@sangfor.com.cn>, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com,
        intel-wired-lan@lists.osuosl.org, jesse.brandeburg@intel.com,
        anthony.l.nguyen@intel.com, keescook@chromium.org,
        grzegorzx.szczurek@intel.com, mateusz.palczewski@intel.com,
        mitch.a.williams@intel.com, gregory.v.rose@intel.com,
        jeffrey.t.kirsher@intel.com, michal.kubiak@intel.com,
        simon.horman@corigine.com, madhu.chittim@intel.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, pengdonglin@sangfor.com.cn,
        huangcun@sangfor.com.cn
Subject: Re: [PATCH net v4 2/2] iavf: Fix out-of-bounds when setting
 channels on remove
Message-ID: <20230503195948.08e9ff1d@kernel.org>
In-Reply-To: <20230503082458.GH525452@unreal>
References: <20230503031541.27855-1-dinghui@sangfor.com.cn>
        <20230503031541.27855-3-dinghui@sangfor.com.cn>
        <20230503082458.GH525452@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, 3 May 2023 11:24:58 +0300 Leon Romanovsky wrote:
> > +		if (test_bit(__IAVF_IN_REMOVE_TASK, &adapter->crit_section))
> > +			return -EOPNOTSUPP;  
> 
> This makes no sense without locking as change to __IAVF_IN_REMOVE_TASK
> can happen any time.

+1, the changes look questionable to me as well.
