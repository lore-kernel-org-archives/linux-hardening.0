Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 856C8C433F5
	for <linux-hardening@archiver.kernel.org>; Sun,  9 Oct 2022 06:32:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbiJIGcp (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 9 Oct 2022 02:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiJIGco (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 9 Oct 2022 02:32:44 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE4C2FC0B
        for <linux-hardening@vger.kernel.org>; Sat,  8 Oct 2022 23:32:44 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id x1so7918557plv.5
        for <linux-hardening@vger.kernel.org>; Sat, 08 Oct 2022 23:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vSk0hKn25FgEiklfFGzsu2I4jcIOoz7J5cFwKLYvUgQ=;
        b=nLcZ5h0RS5hfkUnnyYgnp2Ht+s5+sleB5iMtr77N6+fC1MMlIOdt2w7bjMvu1ZB2nD
         3QZJKEiT5pwzLXN3cDoCLJ2sYPfCs8IA4q6DfV/pYd0QnD+pBciqUhDqBTMG3NMFtjmY
         7cbB8B67PE15QhZ0Mx2UpO5KSF8ou0vztWmliF7Rs9lHwvHjuW9ZxbvBcHexm1/BIH2s
         hGgbrs5sXaBszpVaJiM1t+8DTDc8NRH7xD+ZK5DLYI7spw2OhBm1faR0qITUCQt1D6t6
         C4msxmI3xZvQcw67dzYWBGp3W0cTqy/QIyz4Jtjr1ItKqlVUq5tFQublpSyQCOhesybJ
         /sOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vSk0hKn25FgEiklfFGzsu2I4jcIOoz7J5cFwKLYvUgQ=;
        b=iR8fQbfI8j2booBwvgT4VCMneChtNdDnYrpHg260RNiGkJQg3E8kCpewKQqUOCNAMA
         GdXmi9lnXjETGSoHuy6lB+4ejhBBZkBQDfNa3IVlpeExRJufY9cPjprdVFTdBMFeXt1B
         E+zWytA59cYlK6rwoACdgKtSQvf921pVsXim/KzIfy2woSqkQ0rk1hzx528F+Zw3zwEi
         6B6OO33UBptYKZ1ZzqYA1HBHhNpY4wbNOpSt29s93iroecRvzJLuiqdwgrUoap6rV+Is
         7Ts9+K6ryMsQc4RzE3w7Zd9GOwH8JG5MASSUgvxW1V+V81oz2Pq6pc7V7Bu0U/IkM+Bu
         mQcA==
X-Gm-Message-State: ACrzQf0ckVUdRARCLibQUEUIfK6ff0J/h186xK9DkPIRKP3d2otx+Cms
        wGy9tPyL7Re8QHLdcU0tKYghcKjKqa+HzQ==
X-Google-Smtp-Source: AMsMyM7jttaiGGuIu3iLh4AA4KMmCYzuy2Rz9XSOuuYTFoPZSVUs9g/VOY9cDyNAJRXvUZaiJoGKWw==
X-Received: by 2002:a17:90a:e7ce:b0:20a:c658:c183 with SMTP id kb14-20020a17090ae7ce00b0020ac658c183mr14301551pjb.5.1665297163548;
        Sat, 08 Oct 2022 23:32:43 -0700 (PDT)
Received: from mail.google.com (122-58-209-93-fibre.sparkbb.co.nz. [122.58.209.93])
        by smtp.gmail.com with ESMTPSA id q4-20020a170902dac400b00176675adbe1sm4225546plx.208.2022.10.08.23.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Oct 2022 23:32:42 -0700 (PDT)
Date:   Sun, 9 Oct 2022 19:32:38 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     kernel-hardening@lists.openwall.com
Cc:     linux-hardening@vger.kernel.org
Subject: [Self-introduction] - Paulo Almeida
Message-ID: <Y0JrBsGthQIiSzp+@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi everyone,

My name is Paulo Almeida and as per the instructions listed on the KSPP
page, this is my self-introduction email :)

I will keep it short. 

- My background is in HPC and AI 
- I've been writing software for around 20 years now
- I've written my x86-64 hobbyist OS for fun and in my spare time I've
  writing a MOS 6502 emulator for the same reason.
- Contributing to KSPP is going to be a side project of mine that I plan
  to do outside of business hours... so expect a dedication of a few
  hours per week.

Q: What topics are you interested in?
A: kernel driver development, x86 & ARM hardware architecture, Math, Data
structures, Rust and virtualisation.

Q: What do you want to learn about?
A: I see the KSPP project/initiative as a way to get exposed to pieces
of code that I wouldn't normally come across which is always
appreciated :)

I am also aware of the calibre of developers I will be dealing with and
I'm sure that I will be learning really a lot from them :)

Q: What experience do you have with security, the kernel, programming, 
	or anything else you think is important.
A: 
I've contributed to the kernel a few times time in the past for both
adding features and janitorial tasks.

I took the Linux Kernel Internals (LF420) and the Linux Kernel Debugging
and Security (LF44) courses by the Linux Foundation.

As for other experiences, due to the fact that I wrote my hobbyist OS, I
do have a decent experience with the x86/x86-64 architecture. I also
spent quite sometime writing static analysis parsers.... so should those
experiences help anyone or any possible future plan for the KSPP, please
count on me.

Thanks!

Paulo Almeida

