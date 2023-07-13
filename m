Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA1EC001DE
	for <linux-hardening@archiver.kernel.org>; Thu, 13 Jul 2023 16:53:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235143AbjGMQxf (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 13 Jul 2023 12:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232231AbjGMQxf (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 13 Jul 2023 12:53:35 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A8E2D51
        for <linux-hardening@vger.kernel.org>; Thu, 13 Jul 2023 09:53:22 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1b890e2b9b7so5474725ad.3
        for <linux-hardening@vger.kernel.org>; Thu, 13 Jul 2023 09:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689267202; x=1691859202;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NoNGGvzPoC+CfmJaMdzXCn37KFGOyeGfI/UvmRM+Do0=;
        b=G9AtbbPvATaVSbvSLJQJamXs5udACD6yAYKkKVVbhuaLC65+5LQidnKuoPpjeWgaYV
         Kkq8yIQGtzi7ifWRea8+yytsz/kAGVCRcxsJZdCBkiGqZ9K4yKEPdGjomttT8OLr5UOB
         H4rvrN3juTFhitd2ZgQHx5oFthRgOwbJqCdV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689267202; x=1691859202;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NoNGGvzPoC+CfmJaMdzXCn37KFGOyeGfI/UvmRM+Do0=;
        b=CFQ0cuu+/qi5WnhqHCo+XxkVQnb5N2vaKWRrsXqJUBs9bQl9LnJAZbHrcEf/BZSixu
         3FbYDIdC9jeCaq3mg85EjxXxMOvwN2zUOmR8CvaDxq285AbPWYX5y5bwQX1ABJIQ6C+C
         IO46q62XckCzEYgS63L0tArPYKbpB3YmhVwRk5z2lMj51j9t44CwcRUYXjd2s3Jss7ac
         Mr2WEA1LHOXsqb1jwCFDO1L7701ReKJ95ZpaVM6KeZN0S4HsIUdYfWiPot/HJAOmYKMn
         TyMKz3bnFKgqjXwNK53jPGBLJLFfBuoO4fuk0nY25Ai4jGo66ofCJ4EqQ+TPDz8Yotas
         2UkA==
X-Gm-Message-State: ABy/qLZLxbp1CAm6wXxQUEWOMUYp+h57+VbebgdaVzCg1QYJVzZOKSAo
        cYbm6BdjiIulBsTNcklshFgw1w==
X-Google-Smtp-Source: APBJJlHkhNi7qzNBIMq9ENOHZGdML1MCvQrdLivOAcrVfd4jNxyTp4Ll/r2OE+3aX72+qVOTZosNkQ==
X-Received: by 2002:a17:903:482:b0:1b8:a2af:fe23 with SMTP id jj2-20020a170903048200b001b8a2affe23mr1383903plb.2.1689267202150;
        Thu, 13 Jul 2023 09:53:22 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id f11-20020a17090274cb00b001b077301a58sm6134977plt.79.2023.07.13.09.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 09:53:21 -0700 (PDT)
Date:   Thu, 13 Jul 2023 09:53:20 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux trace kernel <linux-trace-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH] tracing: Add back FORTIFY_SOURCE logic to kernel_stack
 event structure
Message-ID: <202307130953.B54C43B@keescook>
References: <20230713092605.2ddb9788@rorschach.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230713092605.2ddb9788@rorschach.local.home>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Jul 13, 2023 at 09:26:05AM -0400, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> For backward compatibility, older tooling expects to see the kernel_stack
> event with a "caller" field that is a fixed size array of 8 addresses. The
> code now supports more than 8 with an added "size" field that states the
> real number of entries. But the "caller" field still just looks like a
> fixed size to user space.
> 
> Since the tracing macros that create the user space format files also
> creates the structures that those files represent, the kernel_stack event
> structure had its "caller" field a fixed size of 8, but in reality, when
> it is allocated on the ring buffer, it can hold more if the stack trace is
> bigger that 8 functions. The copying of these entries was simply done with
> a memcpy():
> 
>   size = nr_entries * sizeof(unsigned long);
>   memcpy(entry->caller, fstack->calls, size);
> 
> The FORTIFY_SOURCE logic noticed at runtime that when the nr_entries was
> larger than 8, that the memcpy() was writing more than what the structure
> stated it can hold and it complained about it. This is because the
> FORTIFY_SOURCE code is unaware that the amount allocated is actually
> enough to hold the size. It does not expect that a fixed size field will
> hold more than the fixed size.
> 
> This was originally solved by hiding the caller assignment with some
> pointer arithmetic.
> 
>   ptr = ring_buffer_data();
>   entry = ptr;
> 
>   ptr += offsetof(typeof(*entry), caller);
>   memcpy(ptr, fstack->calls, size);
> 
> But it is considered bad form to hide from kernel hardening. Instead, make
> it work nicely with FORTIFY_SOURCE by adding a new __stack_array() macro
> that is specific for this one special use case. The macro will take 4
> arguments: type, item, len, field (whereas the __array() macro takes just
> the first three). This macro will act just like the __array() macro when
> creating the code to deal with the format file that is exposed to user
> space. But for the kernel, it will turn the caller field into:
> 
>   type item[] __counted_by(field);
> 
> or for this instance:
> 
>   unsigned long caller[] __counted_by(size);
> 
> Now the kernel code can expose the assignment of the caller to the
> FORTIFY_SOURCE and everyone is happy!
> 
> Link: https://lore.kernel.org/linux-trace-kernel/20230712105235.5fc441aa@gandalf.local.home/
> 
> Suggested-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Yay! This looks good. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
