Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A8D7C4332F
	for <linux-hardening@archiver.kernel.org>; Fri, 18 Nov 2022 22:25:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbiKRWZs (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 18 Nov 2022 17:25:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232020AbiKRWZa (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 18 Nov 2022 17:25:30 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7435BB5C7F
        for <linux-hardening@vger.kernel.org>; Fri, 18 Nov 2022 14:25:24 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d20so5740738plr.10
        for <linux-hardening@vger.kernel.org>; Fri, 18 Nov 2022 14:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=udXLh+J6w3uqoSbPpBqZZA43Ss/afXLWiCuFYr88dFs=;
        b=fy1lW516fh8UMd+1ve1cxazywckpR7JjlSXrBxsiEMcqM/4+WYlg1VswAgkj/F8Az5
         Vck7DPt8fG2RdTa7/lKuEETBuwQDqQ3DITUuLSxy9OiUJ/qGLPOE5u4eLkVPRUjY5f1O
         mlUwdUjE7Je0bJaYN9YvKzoD1s2pK5P4+BlYk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=udXLh+J6w3uqoSbPpBqZZA43Ss/afXLWiCuFYr88dFs=;
        b=wEzRZkhDBu66DFQsTpQWFC5BaPyzwwSDt2jXbBS1QcjWs3HcpAXPXgLCwjbj66u5sG
         Xbo1VsyqCeAR9OHGNNXGaC/4uLWzzUphlu9oS80EWm7ft4keoPv6iWmjAvn1rx13fCX5
         9c35W+P1NgM6kupNyYi0xINJDFQp+OZA4X5+NcVtstrOhZszqFCfLS4DrWMprHebl0Ri
         NECR0t79IacA8ZMqzA3J8yZzXqpiJWnvz0GEfzO0z9QaiqtcOe93lp2FD47wORa2nBl8
         SiFDziuIYrA0t+Wps4ov4eu9Kx9i/r8kaETumHGZhLin6gmMcS1GEN6zUfgOe5P0koQ0
         cvGQ==
X-Gm-Message-State: ANoB5png49MmAc6QfxN4X+FJx2rvxFmW2jkf0cyl+L6sNEyf0Tp7OAi4
        eO/8pKYN0UolObFjvZ9jjIKllA==
X-Google-Smtp-Source: AA0mqf4o4ZRdWJrRpJOaePOBA3aqkXbCq+zGM9Tz3iyp6uOYNyoTxjUR875eGPzlGkAr2T0o013gaQ==
X-Received: by 2002:a17:903:328e:b0:188:f5de:a8e3 with SMTP id jh14-20020a170903328e00b00188f5dea8e3mr1487500plb.109.1668810323947;
        Fri, 18 Nov 2022 14:25:23 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o65-20020a625a44000000b00562664d5027sm3709368pfb.61.2022.11.18.14.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 14:25:23 -0800 (PST)
Date:   Fri, 18 Nov 2022 14:25:22 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Luca Coelho <luciano.coelho@intel.com>,
        Haim Dreyfuss <haim.dreyfuss@intel.com>,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        Petr Stourac <pstourac@redhat.com>,
        linux-kernel@vger.kernel.org,
        Mordechay Goodstein <mordechay.goodstein@intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Nathan Errera <nathan.errera@intel.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Shaul Triebitz <shaul.triebitz@intel.com>,
        netdev@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>,
        Abhishek Naik <abhishek.naik@intel.com>,
        Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
        Ayala Beker <ayala.beker@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org,
        Sriram R <quic_srirrama@quicinc.com>,
        Kalle Valo <kvalo@kernel.org>,
        Mike Golant <michael.golant@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-next@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: Coverity: iwl_mvm_sec_key_add(): Memory - corruptions
Message-ID: <202211181424.794FCAD@keescook>
References: <202211180854.CD96D54D36@keescook>
 <d4c07fa45de290f32611420e2f116d8a6e32d22a.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4c07fa45de290f32611420e2f116d8a6e32d22a.camel@sipsolutions.net>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Nov 18, 2022 at 10:04:38PM +0100, Johannes Berg wrote:
> On Fri, 2022-11-18 at 08:54 -0800, coverity-bot wrote:
> > 
> > *** CID 1527370:  Memory - corruptions  (OVERRUN)
> > drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c:123 in iwl_mvm_sec_key_add()
> > 117
> > 118     	if (WARN_ON(keyconf->keylen > sizeof(cmd.u.add.key)))
> > 119     		return -EINVAL;
> > 120
> > 121     	if (keyconf->cipher == WLAN_CIPHER_SUITE_WEP40 ||
> > 122     	    keyconf->cipher == WLAN_CIPHER_SUITE_WEP104)
> > vvv     CID 1527370:  Memory - corruptions  (OVERRUN)
> > vvv     Overrunning buffer pointed to by "cmd.u.add.key + 3" of 32 bytes by passing it to a function which accesses it at byte offset 34 using argument "keyconf->keylen" (which evaluates to 32). [Note: The source code implementation of the function has been overridden by a builtin model.]
> > 123     		memcpy(cmd.u.add.key + IWL_SEC_WEP_KEY_OFFSET, keyconf->key,
> > 124     		       keyconf->keylen);
> > 125     	else
> > 126     		memcpy(cmd.u.add.key, keyconf->key, keyconf->keylen);
> > 127
> > 128     	if (keyconf->cipher == WLAN_CIPHER_SUITE_TKIP) {
> > 
> > If this is a false positive, please let us know so we can mark it as
> > such, or teach the Coverity rules to be smarter. If not, please make
> > sure fixes get into linux-next. :) For patches fixing this, please
> > include these lines (but double-check the "Fixes" first):
> > 
> 
> Well, I don't think you can teach coverity this easily, but the
> WARN_ON() check there is not really meant to protect this - WEP keys
> must have a length of either 5 or 13 bytes (40 or 104 bits!).
> 
> So there's no issue here, but I'm not surprised that coverity wouldn't
> be able to figure that out through the stack.

Gotcha. And some other layer is doing the verification that cipher and
keylen are correctly matched?

-- 
Kees Cook
