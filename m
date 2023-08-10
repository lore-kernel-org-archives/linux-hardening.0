Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A21C001DE
	for <linux-hardening@archiver.kernel.org>; Thu, 10 Aug 2023 17:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233549AbjHJReJ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 10 Aug 2023 13:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233030AbjHJReJ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 10 Aug 2023 13:34:09 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5562B2715
        for <linux-hardening@vger.kernel.org>; Thu, 10 Aug 2023 10:34:08 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-34992fd567bso1547395ab.1
        for <linux-hardening@vger.kernel.org>; Thu, 10 Aug 2023 10:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691688847; x=1692293647;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GdV4iR1xxtboZs5FQPuJUZtXcGLHtIDsoRCRiJm05c4=;
        b=f49m7e0fTpMvMzTJELh+6sHJ1ejSFDxI40Hzkiwl3GIxcq/hxl/PROqKNx//p59fGK
         pB6pv72ip3SU34UFbF4JTU1fUHt+t/ecMn+3dXUwoPjoTg+hhoNRqsE+q+F9PzLsOWih
         Eug9n5HfoEAkeL3oP9HcAWidpQzyXF3r3BjPr1kJtYmDv9gJXfZYNpJ69K4NBlV26aTb
         47DUVLNEHv9xIzbXdB7wZzHLYiz2AwWEYlB6BL3hiBmZbHckPxQo4gZG6oYYulEFDQfz
         UIIzRB88jqmCOW7O4bx64FM7jd8t3u6dYQ1HRCNl2FCf+wOJHkdrHYp+O0bGDjrAFUEf
         Of3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691688847; x=1692293647;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GdV4iR1xxtboZs5FQPuJUZtXcGLHtIDsoRCRiJm05c4=;
        b=DZuqHe4psCsw60u2M4ZIl9whqobI3omr9omB++2W8SOuHfAl+jExaUnFjpOsJI25hX
         fVjdenr99yUFS6+JALCtg8Md+VTlSHM/fX3hYu7dlfMjOYkEeRfphFGFtOxXQSvQdfba
         iLZXlL8Dmnqir1H4S2kNEWdjfEosWnwckoiCVOfQAsV3t/Sqb5I2R+S7qJ4SfXFjYkzu
         5cLqzF57SJDnQtC+ErGAUmQ2Q6mxSNmL+me+C1W8rW4IBQHeKFrzPknMMxV1vsYSbNt6
         EccvaOxA0rKb6sJftM4kFKr3+o+Og8KvJI28Ogt8sPDpR9q3/JHpFMn/bfyMRgw1k7KN
         9cQQ==
X-Gm-Message-State: AOJu0YxiFc/NXxmU9AOk7KNGC+7v1bilCmf977N4fm5e0NrSlOiZ3gWy
        rJN9EtW42Q1ju0FNuom2XP/H4KCjfNV+iTZ8VTx2IQ==
X-Google-Smtp-Source: AGHT+IFjuDr680+2jafpw07ddfS/d3QHLVYJH7X3GvqWM5wSrbwFXF5hRN0rsbXDvNUnU1YujztEDw==
X-Received: by 2002:a05:6e02:1baf:b0:349:46fa:3844 with SMTP id n15-20020a056e021baf00b0034946fa3844mr2889307ili.3.1691688847549;
        Thu, 10 Aug 2023 10:34:07 -0700 (PDT)
Received: from google.com (161.74.123.34.bc.googleusercontent.com. [34.123.74.161])
        by smtp.gmail.com with ESMTPSA id l17-20020a92d8d1000000b00345d2845c42sm566851ilo.57.2023.08.10.10.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 10:34:06 -0700 (PDT)
Date:   Thu, 10 Aug 2023 17:34:04 +0000
From:   Justin Stitt <justinstitt@google.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 2/4][next] i40e: Replace one-element array with
 flex-array member in struct i40e_profile_segment
Message-ID: <20230810173404.jjuvqo5tv57en7pg@google.com>
References: <cover.1690938732.git.gustavoars@kernel.org>
 <52da391229a45fe3dbd5c43167cdb0701a17a361.1690938732.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52da391229a45fe3dbd5c43167cdb0701a17a361.1690938732.git.gustavoars@kernel.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Aug 01, 2023 at 11:05:59PM -0600, Gustavo A. R. Silva wrote:
> One-element and zero-length arrays are deprecated. So, replace
> one-element array in struct i40e_profile_segment with flexible-array
> member.
>
> This results in no differences in binary output.
>
> Link: https://github.com/KSPP/linux/issues/335
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_type.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
Tested-by: Justin Stitt <justinstitt@google.com>

>
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_type.h b/drivers/net/ethernet/intel/i40e/i40e_type.h
> index c3d5fe12059a..f7a984304b65 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_type.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e_type.h
> @@ -1487,7 +1487,7 @@ struct i40e_profile_segment {
>  	struct i40e_ddp_version version;
>  	char name[I40E_DDP_NAME_SIZE];
>  	u32 device_table_count;
> -	struct i40e_device_id_entry device_table[1];
> +	struct i40e_device_id_entry device_table[];
>  };
>
>  struct i40e_section_table {
> --
> 2.34.1
>
