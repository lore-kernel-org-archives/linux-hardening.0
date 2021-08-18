Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-25.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1050C4338F
	for <linux-hardening@archiver.kernel.org>; Wed, 18 Aug 2021 23:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1443610D2
	for <linux-hardening@archiver.kernel.org>; Wed, 18 Aug 2021 23:29:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232954AbhHRX3z (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 18 Aug 2021 19:29:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:39050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232862AbhHRX3z (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 18 Aug 2021 19:29:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 42C54610CE;
        Wed, 18 Aug 2021 23:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629329359;
        bh=m455H5KlC5gIpoNw+1URlD4LYf70e3UDXeBkiP2eyQA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=tl0CnCvLd3z5arNC7oa/KNSdxvUH7B9AJtnkrwV7j4o5kSJa18jC1oCzGOKbh+gki
         muCnWDpPg30sDEBq8Andp9inq9ZpWAu+G1iR/4DSUzl5xMF5/C5VehuQ4IHu45fFoz
         FYh9tX2JHQkppr+HeimHvh9Ya3xZ/OKsASMkrmiy55KuKzZPWeFERtp+uBQAocLMGw
         zDNIyECkGE5CTqySM44GsKdABFDQyNOR8YqsRDpFIopQaUSVgUwPoOYAsQYuT+RtE3
         ndWTRt9KPmtBPdSsi2C4+ywt5W5EvrQcG2OjJmGAAU4Rl2gtim1/w13HffvDUtSK/J
         PotJ/5mCT6amg==
Subject: Re: [PATCH][next] fs/ntfs3: Fix fall-through warnings for Clang
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20210818222146.GA312859@embeddedor>
From:   Nathan Chancellor <nathan@kernel.org>
Message-ID: <6b9a6c49-1b32-c5bc-6313-b0a888e93923@kernel.org>
Date:   Wed, 18 Aug 2021 16:29:18 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210818222146.GA312859@embeddedor>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 8/18/2021 3:21 PM, Gustavo A. R. Silva wrote:
> Fix the following fallthrough warnings:
> 
> fs/ntfs3/inode.c:1792:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
> fs/ntfs3/index.c:178:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
> 
> This helps with the ongoing efforts to globally enable
> -Wimplicit-fallthrough for Clang.
> 
> Link: https://github.com/KSPP/linux/issues/115
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>   fs/ntfs3/index.c | 1 +
>   fs/ntfs3/inode.c | 1 +
>   2 files changed, 2 insertions(+)
> 
> diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
> index 6aa9540ece47..76eae60b7fce 100644
> --- a/fs/ntfs3/index.c
> +++ b/fs/ntfs3/index.c
> @@ -175,6 +175,7 @@ static inline NTFS_CMP_FUNC get_cmp_func(const struct INDEX_ROOT *root)
>   		default:
>   			break;
>   		}
> +		break;
>   	default:
>   		break;
>   	}
> diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
> index bf51e294432e..a573c6e98cb8 100644
> --- a/fs/ntfs3/inode.c
> +++ b/fs/ntfs3/inode.c
> @@ -1789,6 +1789,7 @@ int ntfs_unlink_inode(struct inode *dir, const struct dentry *dentry)
>   	switch (err) {
>   	case 0:
>   		drop_nlink(inode);
> +		break;
>   	case -ENOTEMPTY:
>   	case -ENOSPC:
>   	case -EROFS:
> 

