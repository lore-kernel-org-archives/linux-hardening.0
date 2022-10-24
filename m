Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46097C67871
	for <linux-hardening@archiver.kernel.org>; Mon, 24 Oct 2022 19:34:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbiJXTet (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 24 Oct 2022 15:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233433AbiJXTeO (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 24 Oct 2022 15:34:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41EF786F7;
        Mon, 24 Oct 2022 11:04:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C13CE6151C;
        Mon, 24 Oct 2022 18:03:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 224FEC433D6;
        Mon, 24 Oct 2022 18:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666634617;
        bh=fqL8dwseMRVhi3wyP08JG12vPtKS12OItkJ7NcHZ3TM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=XRkRjx9VrhV0zPkEHQkJOJqGesOUCi89qvD4Fu61tCrkRJ5YwtO0UwD1DIbQgGi53
         9PneUXID2icTaFnbjWl8m/Yl85icwz6COfCS40mAZ8NN/JvejTCgr7KeQusnn5xJw9
         pIrRYzeszd3KG8n5uUsG1mVSkuuD/wPcnIIk/ZNRRo3zI0l+x0jSREYioPFv6s/BP9
         aXf3Kv4mVd4uOz286X1Pa21psFvyA6y0plIC8NZfP78oOWkqTVKivfhMlP4mrLmzUO
         JW5XmlHEPLOhNBt+iopR3KVeiC//YQ3p/Kc7Uwq4el80UPLR7THQ11NunOdSnXwED5
         0WqubDEcbBACA==
Message-ID: <a9c6c111-d92f-f76f-1b7a-f6220d755eeb@kernel.org>
Date:   Mon, 24 Oct 2022 20:03:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH] mempool: Use kmalloc_size_roundup() to match ksize()
 usage
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20221018090323.never.897-kees@kernel.org>
 <20221018155137.f6898d165aade2e3a5f0b2d3@linux-foundation.org>
 <202210182235.3B19DFCB28@keescook>
From:   "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <202210182235.3B19DFCB28@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 10/19/22 07:37, Kees Cook wrote:
> On Tue, Oct 18, 2022 at 03:51:37PM -0700, Andrew Morton wrote:
>> On Tue, 18 Oct 2022 02:03:29 -0700 Kees Cook <keescook@chromium.org> wrote:
>> 
>> > Round up allocations with kmalloc_size_roundup() so that mempool's use
>> > of ksize() is always accurate and no special handling of the memory is
>> > needed by KASAN, UBSAN_BOUNDS, nor FORTIFY_SOURCE.
>> 
>> Confused.  If the special handling is not needed, why doesn't the patch
>> removed the no longer needed special handling?
> 
> The special handling is in the ksize() implementation, so it can't be
> removed[1] until all the ksize()-affected users are updated to see their
> true allocation sizes first.
> 
> [1] https://lore.kernel.org/lkml/20220923202822.2667581-16-keescook@chromium.org/

But in the previous version I was wondering if we can just stop doing
ksize()-like poison handling in mempool completely, if no mempool consumers
call ksize() to expand their use of the allocated objects. You seemed to
agree but this version is uncahnged?

https://lore.kernel.org/all/f4fc52c4-7c18-1d76-0c7a-4058ea2486b9@suse.cz/


